Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313323AbSDJRNr>; Wed, 10 Apr 2002 13:13:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313338AbSDJRNq>; Wed, 10 Apr 2002 13:13:46 -0400
Received: from bbnrel4.net.external.hp.com ([155.208.254.68]:1545 "HELO
	bbnrel4.net.external.hp.com") by vger.kernel.org with SMTP
	id <S313323AbSDJRNo>; Wed, 10 Apr 2002 13:13:44 -0400
Message-ID: <3CB472BE.4030708@hp.com>
Date: Wed, 10 Apr 2002 19:13:34 +0200
From: Francois-Xavier Kowalski <francois-xavier_kowalski@hp.com>
Reply-To: francois-xavier_kowalski@hp.com
Organization: Hewlett-Packard
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:0.9.9) Gecko/20020311
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel mailing-list <linux-kernel@vger.kernel.org>
Cc: Larry Kessler <lkessler@us.ibm.com>,
        evlog-developers Mailing-List 
	<evlog-developers@lists.sourceforge.net>
Subject: Re: Event logging vs enhancing printk
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Michel Dagenais <michel.dagenais@polymtl.ca> writes

>> People want to be able to get better debug information, with more detail
>> than is currently possible with printk, hence the Event logging project.
>
>I would like to emphasize that point; logging and tracing is of prime 
>importance in several areas:
>
>- Telecom and Security. Logging and auditing is a requirement in Telecom 
>  applications. It is for instance one of the important features of the 
>  Distributed Security Infrastructure proposed by Ericsson Research and to 
>  be presented in a couple of months at the Ottawa Linux Symposium.
>  The OSDL "Carrier Grade Linux" is certainly no different.
>

I am currently working in the Telecom area (signalling), on systems that 
usually process several tenths of thousands of telephone calls per 
second, during years. So I am the kind of guy interrested in having 
enhancements to the Linux logging sub-systems, to:

   1. Make my life easier when something goes wrong on my user's sites &
      I am supposed to gather the information from the logs.
   2. Make my user's life easier, to detect that something is going
      wrong on my machines (among hunderds of other ones), so that he
      can (try to) join me.
   3. Make my developer's life easier, not forcing me to code yet
      another log parser dedicated to one system & use open standard
      instead.
   4. Not make my Linux desktop system an intensive disk & CPU consume r
      for logging-only purpose (this is more a personal view than a
      professional constraint... :-)

I have been following the work done by evlog team since a few monthes 
now, so I can say now - as an evlog user - that it provides support for 
every requirements listed above, the following ways:

    * Evlog can be configured to flag log messages as part of a
      functional area (facilty) so that they can be logged in separated
      log files, regardless of the source of the log: kernel or
      userland. Take the case of a telecom protocol stack running partly
      in kernel space (device driver and/or protocol module) and partly
      in userland (application). Evlog can be configured a way so that
      logs coming from the telecom functional area are consolidated at
      the same place. If something goes wrong in kernel space, the logs
      of the whole telecom sub-system are placed together showing
      (mostly) the appropriated order of failure. This considerably
      helps troubleshooting a failure (my trouble-shooting life).
    *  From the telecom network supervision/management perspective (my
      user's life), the ability of evlog to have registered call-backs
      (in user-land) on specified (configured) events permits to:
          o Take automatic corrective actions if possible
          o Raise network alarms, so that the operators can log on the
            system & trouble-shoot it (or at least apply a corrective
            procedure & call a help-desk)
    * Evlog is a proposed standard to POSIX. I do hope that it will be
      accepted (as well as in the LSB, but this is probably another
      story...), so that the telecom stack & network supervision work
      can be re-used from one system to another.
    * Evlog can be totally optimized away at kernel configuration time
      (like any other CONFIG_XXX component, after all), or have no
      noticeable no cost when compiled-in & powered-off. (my day-to-day
      Linux desktop user life).

For the reasons listed above, I strongly support integrating evlog in 
the Linux kernel.

FiX

-- 
Francois-Xavier "FiX" KOWALSKI     /_ __    Tel: +33 (0)4 76 14 63 27
Telecom Infrastructure Division   / //_/    Fax: +33 (0)4 76 14 43 23
SigTech eXpert                      /       HP Telnet: 779-6327
                               i n v e n t  http://www.hp.com/go/opencall




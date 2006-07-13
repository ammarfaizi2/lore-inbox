Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030299AbWGMTO4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030299AbWGMTO4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 15:14:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030298AbWGMTO4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 15:14:56 -0400
Received: from smtp.andrew.cmu.edu ([128.2.10.81]:1720 "EHLO
	smtp.andrew.cmu.edu") by vger.kernel.org with ESMTP
	id S1030302AbWGMTOz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 15:14:55 -0400
Message-ID: <44B69BA9.1010505@cmu.edu>
Date: Thu, 13 Jul 2006 15:14:49 -0400
From: George Nychis <gnychis@cmu.edu>
User-Agent: Thunderbird 1.5.0.4 (X11/20060612)
MIME-Version: 1.0
To: Jeremy Fitzhardinge <jeremy@goop.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       hnazfoo@googlemail.com
Subject: Re: suspend/hibernate to work on thinkpad x60s?
References: <44B5CE77.9010103@cmu.edu> <44B604C8.90607@goop.org> <44B64F57.4060407@cmu.edu> <44B66740.2040706@goop.org>
In-Reply-To: <44B66740.2040706@goop.org>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey,

x60s gnychis # echo -n mem > /sys/power/state
bash: echo: write error: Operation not permitted
x60s gnychis # cat /sys/power/state
standby mem

I think I have acpid installed, it is a Gentoo system:
[ebuild   R   ] sys-power/acpid-1.0.4-r3  USE="-doc -logrotate" 22 kB


I think I've already set up some acpid stuff for my CPU frequency
scaling capabilities, I followed this guide:
ttp://www.gentoo.org/doc/en/power-management-guide.xml

I modified:
/etc/acpi/actions/pmg_switch_runlevel.sh

If i "tail -f /var/log/acpid" and try to suspend the system or shut the
lid, no new messages come up.  If i pull my power cable to switch
between AC and battery, messages do come up.

Whats my next step here?

Thanks!
George


Jeremy Fitzhardinge wrote:
> George Nychis wrote:
>> I am not seeing any problems at all, though I am not seeing anything
>> happen :)
>>
>> If I Fn+suspend... nothing happens ... if i Fn+hibernate ... nothing
>> happens
>>
>> What patches did you use?
> Sounds like your first step is to set up acpi.  What distro are you
> using?  What happens if you do "echo -n mem > /sys/power/state"?
> 
> The patches you need are to make the ahci disk interface resume
> properly.  There's a series of 6 patches from Forrest Zhao which he
> posted to the linux-ide list, and they apply cleanly to 2.6.18-rc1-mm1.
> 
>    J
> 
> 

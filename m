Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269186AbUJKTOZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269186AbUJKTOZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 15:14:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269179AbUJKTOZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 15:14:25 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:11 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S269186AbUJKTOH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 15:14:07 -0400
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: "J.A. Magallon" <jamagallon@able.es>, Hacksaw <hacksaw@hacksaw.org>
Subject: Re: udev: what's up with old /dev ?
Date: Mon, 11 Oct 2004 22:13:58 +0300
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org
References: <200410102315.i9ANF7OI019460@hacksaw.org> <1097450746l.5993l.0l@werewolf.able.es>
In-Reply-To: <1097450746l.5993l.0l@werewolf.able.es>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410112213.58801.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 11 October 2004 02:25, J.A. Magallon wrote:
> 
> On 2004.10.11, Hacksaw wrote:
> > >The very first thing init does is open /dev/console, and if it doesn't
> > >exist the entire boot hangs.
> > 
> > This raises a question: Would it be a useful thing to make a modified init 
> > that could run udev before it does anything else?
> 
> I don't think it is needed. There is no problem (i am thinking on rootles
> nodes and PXE and so on...) on building a simple initrd with /dev/console,
> /dev/null and half a dozen standard devices if they are needed. Just
> to get udev run and have your real devices mounted there and overwrite
> them.
> 
> I just remember one other oddity. To clean up my system, I copied the
> running /dev to /dev-new, moved /dev to /dev-old and /dev-new to /dev.
> But on 'reboot', I got a complaint about /dev/initctl not opening.
> This could happen also with init. It opens real /dev/initctl on boot,
> mounts /dev and tries to use new /dev/inittclt on shutdown...

What /dev/initctl? Why do you have a pipe in a directory
which supposed to have device nodes only?

Get better init.
--
vda


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262435AbVA0EuU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262435AbVA0EuU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 23:50:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262192AbVA0EuU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 23:50:20 -0500
Received: from smtp811.mail.sc5.yahoo.com ([66.163.170.81]:44631 "HELO
	smtp811.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262435AbVA0EuO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 23:50:14 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Sasa Stevanovic <mg94c18@alas.matf.bg.ac.yu>
Subject: Re: Possible bug in keyboard.c (2.6.10)
Date: Wed, 26 Jan 2005 23:50:11 -0500
User-Agent: KMail/1.7.2
Cc: linux-kernel@vger.kernel.org
References: <Pine.LNX.4.61.0501270318290.4545@82.117.197.34>
In-Reply-To: <Pine.LNX.4.61.0501270318290.4545@82.117.197.34>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Message-Id: <200501262350.11896.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 26 January 2005 22:16, Sasa Stevanovic wrote:
> Hi,
> 
> I had some problems with my laptop's onetouch keys and it eventually led me to 
> keyboard.c file from 2.6.10 kernel (Vojtech Pavlik and others).  There may be 
> a bug in the file, please read below.
> 
> Well, actually, when all omnibook/messages/setkeycodes/hotkeys/xev/showkey etc 
> stuff is stripped off, what remains is that x86_keycodes array has only first 
> 240 members initialized, while remaining 16 are set to 0 due to [256]:
> 
> static unsigned short x86_keycodes[256] = { <only 240 here> };
> 
> (For my scenario, workaround was possible.)
> 
> I am not sure if this is a bug or not; it worked in 2.4.18 without workaround. 
> Might be that someone wanted to prevent reading invalid memory.  There are 
> many versions of the file/array definition found on the web, none of which has 
> a comment about this.
> 

>From Vojetch Pavilk:
> I'm sorry, but X only understands the RAW PS/2 protocol, and that one
>  can only transport keycodes up to 240.
>  
>  For keycodes above 240, XFree86 would either need to use the MediumRAW
>  mode, or use event devices for parsing the keyboard.
http://www.ussg.iu.edu/hypermail/linux/kernel/0406.0/0544.html

You still did not describe what kind of problems you are having with your
keys.

-- 
Dmitry

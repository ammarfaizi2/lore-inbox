Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266952AbTAUJO1>; Tue, 21 Jan 2003 04:14:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266961AbTAUJO1>; Tue, 21 Jan 2003 04:14:27 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:55822 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S266952AbTAUJO0>;
	Tue, 21 Jan 2003 04:14:26 -0500
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: "Ph. Marek" <philipp.marek@bmlv.gv.at>
Cc: linux-kernel@vger.kernel.org
Subject: Re: printk() without KERN_ prefixes? (in 2.5.59) and Q: small kernel image doc 
In-reply-to: Your message of "Tue, 21 Jan 2003 09:58:43 BST."
             <200301210930.14551.philipp.marek@bmlv.gv.at> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 21 Jan 2003 20:23:20 +1100
Message-ID: <12940.1043141000@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Jan 2003 09:58:43 +0100, 
"Ph. Marek" <philipp.marek@bmlv.gv.at> wrote:
>Should they be fixed to KERN_INFO or some such? I'm willing to contribute a 
>patch (which will be done by script, of course). Or am I missing something 
>and they shall stay as they are?

Do not blindly add KERN_*.  Some prints are done with multiple calls to
printk(), only the first call should have KERN_*, otherwise you get
lines like this, with embedded '<n>' strings.

  /dev/xscsi/pci01.00.0-1/target0/lun0:<6> p1<6> p2<6> p3<6> p4 <<6> p5<6> p6<6> p7 >


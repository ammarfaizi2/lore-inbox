Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129076AbQKGNwF>; Tue, 7 Nov 2000 08:52:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129432AbQKGNv4>; Tue, 7 Nov 2000 08:51:56 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:55314 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S129076AbQKGNvk>;
	Tue, 7 Nov 2000 08:51:40 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Horst von Brand <vonbrand@inf.utfsm.cl>
cc: linux-kernel@vger.kernel.org
Subject: Re: Persistent module storage - modutils design 
In-Reply-To: Your message of "Tue, 07 Nov 2000 10:30:39 -0300."
             <200011071330.eA7DUdw26230@pincoya.inf.utfsm.cl> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 08 Nov 2000 00:51:33 +1100
Message-ID: <14032.973605093@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 07 Nov 2000 10:30:39 -0300, 
Horst von Brand <vonbrand@inf.utfsm.cl> wrote:
>> Keith Owens <kaos@ocs.com.au> said:
>> > I have not decided where to save the persistent module parameters.  It
>> > could be under /lib/modules/<version>/persist or it could be under
>> > /var/log or /var/run.  I am tending towards /var/run/module_persist, in
>> > any case it will be a modules.conf parameter.
>
>Note! This _has_ to be in the / filesystem so it works before mounting the
>rest of the stuff (if ever). This would rule out /var, and leave just
>/lib/modules/<version>. Makes me quite unhappy...

Modules are loaded before non-root file systems are mounted, damn!
Looks like persistent data has to be stored in /lib/modules/persist (no
<version>, see earlier mail).  If somebody wants both a read only /lib
and persistent data then /lib/modules/persist must be a symlink and
they must mount the target file system before loading modules with
persistent data.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

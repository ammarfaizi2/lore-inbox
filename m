Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286557AbSAMR2O>; Sun, 13 Jan 2002 12:28:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286462AbSAMR2F>; Sun, 13 Jan 2002 12:28:05 -0500
Received: from ns.suse.de ([213.95.15.193]:60168 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S286411AbSAMR14>;
	Sun, 13 Jan 2002 12:27:56 -0500
To: 520047054719-0001@t-online.de (Oliver Neukum)
Cc: linux-kernel@vger.kernel.org
Subject: Re: ugly warnings with likely/unlikely
In-Reply-To: <16PjOb-0oLbCCC@fwd11.sul.t-online.com.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 13 Jan 2002 18:27:54 +0100
In-Reply-To: 520047054719-0001@t-online.de's message of "13 Jan 2002 13:25:57 +0100"
Message-ID: <p73r8ou2mat.fsf@oldwotan.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

520047054719-0001@t-online.de (Oliver Neukum) writes:

> Hi,
> 
> if (likely(stru->pointer))
> 
> results in an ugly warning about using pointer as int.
> Is there something that could be done against that ?

Just use 

if (!stru->pointer) { 
	...
}

instead. gcc and a lot of other compilers predict all pointer tests
against NULL as unlikely, unless you override that.

-Andi (who is a bit worried about the unlikelies multiplicating like rabbits)
 

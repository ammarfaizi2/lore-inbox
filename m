Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132299AbRBDU14>; Sun, 4 Feb 2001 15:27:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132283AbRBDU1q>; Sun, 4 Feb 2001 15:27:46 -0500
Received: from jalon.able.es ([212.97.163.2]:23492 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S132175AbRBDU1f>;
	Sun, 4 Feb 2001 15:27:35 -0500
Date: Sun, 4 Feb 2001 21:27:22 +0100
From: "J . A . Magallon" <jamagallon@able.es>
To: mathieu_dube@videotron.ca
Cc: linux-kernel@vger.kernel.org, davids@webmaster.com
Subject: RE: accept
Message-ID: <20010204212722.A1029@werewolf.able.es>
In-Reply-To: <NCBBLIEPOCNJOAEKBEAKGEICNHAA.davids@webmaster.com> <01020411401700.00110@grndctrl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <01020411401700.00110@grndctrl>; from mathieu_dube@videotron.ca on Sun, Feb 04, 2001 at 17:37:43 +0100
X-Mailer: Balsa 1.1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 02.04 Mathieu Dube wrote:
> Ok, but fd 0 cant be a valid socket since its the stdin
> 
> I posted that on this mailing list coz I thought that this might be a scaling
> problem since it happens when theres already several clients connected to the
> server
> 

It just mean that your stdin was closed some time in the past...
As the prog is a daemon, probably it closed its std{in,out,err} and its
controlling tty.

I do not know if Linux follows the rule that the first fd you get is the
first available. That means that after 'daemonize' you should get the 0
in the first connection. If fd reuse is delayed, you can get the 0 any time
after...

-- 
J.A. Magallon                                                      $> cd pub
mailto:jamagallon@able.es                                          $> more beer

Linux werewolf 2.4.2-pre1 #1 SMP Sun Feb 4 13:04:30 CET 2001 i686

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

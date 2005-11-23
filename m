Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751201AbVKWQF5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751201AbVKWQF5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 11:05:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751204AbVKWQFq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 11:05:46 -0500
Received: from web25812.mail.ukl.yahoo.com ([217.146.176.245]:24451 "HELO
	web25812.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1751201AbVKWQFo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 11:05:44 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.fr;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=K1qbN0E5NALnoyS+83EYmh7lxbe8u9IYmfcNzsu/5WqfiayQX/9AoEeVlB/VKTQSgKc/+7Y3EDsYPQNhhCS4knMOQP3eik8ZcQpZmwfAs4g2TkoVFUmvEzPAdl+UCWHP3U64MCzYXu7mvhXPcJXNbEspQg8Z/zfgSJ3ZMwgDijU=  ;
Message-ID: <20051123160542.71232.qmail@web25812.mail.ukl.yahoo.com>
Date: Wed, 23 Nov 2005 17:05:42 +0100 (CET)
From: moreau francis <francis_moreau2000@yahoo.fr>
Subject: Re: Use enum to declare errno values
To: Nikita Danilov <nikita@clusterfs.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <17284.37107.573883.328659@gargle.gargle.HOWL>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- Nikita Danilov <nikita@clusterfs.com> a écrit :
> 
> No it shouldn't. Following is a perfectly legal thing to do in C:
> 
> enum side {
>         LEFT,
>         RIGHT
> };
> 
> int foo(int x)
> {
>         if (x & 0x1)
>                 return LEFT;
>         else
>                 return RIGHT;
> }
> 
> This is not C++ fortunately.
> 
> Nikita.
> 

hmm, are you sure that debuggers will tell you that foo returns LEFT/RIGHT but
not any integer value ?

I just give a try and unfortunately you seem to be wrong here:

""""
(gdb) s
foo (x=1) at enum_test.c:8
8               if (x & 0x1)
(gdb) finish
Run till exit from #0  foo (x=1) at enum_test.c:8
0x0804837c in main (argc=1, argv=0xbfe14dc4) at enum_test.c:17
17              return foo(1);
Value returned is $1 = 0
(gdb)
""""

But we needn't change all function prototypes that return an errno value in one
shot because as you said we can mix enum and int.

Thanks





	

	
		
___________________________________________________________________________ 
Appel audio GRATUIT partout dans le monde avec le nouveau Yahoo! Messenger 
Téléchargez cette version sur http://fr.messenger.yahoo.com

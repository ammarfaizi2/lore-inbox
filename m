Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262426AbTCROdn>; Tue, 18 Mar 2003 09:33:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262427AbTCROdn>; Tue, 18 Mar 2003 09:33:43 -0500
Received: from [66.70.28.20] ([66.70.28.20]:35076 "EHLO
	maggie.piensasolutions.com") by vger.kernel.org with ESMTP
	id <S262426AbTCROdl>; Tue, 18 Mar 2003 09:33:41 -0500
Date: Tue, 18 Mar 2003 15:46:32 +0100
From: DervishD <raul@pleyades.net>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: "Sparks, Jamie" <JAMIE.SPARKS@cubic.com>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: select() stress
Message-ID: <20030318144632.GB1438@DervishD>
References: <Pine.WNT.4.44.0303171010580.1544-100000@GOLDENEAGLE.gameday2000> <Pine.LNX.4.53.0303171112090.22652@chaos> <20030318102837.GH42@DervishD> <Pine.LNX.4.53.0303180758380.26753@chaos>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.53.0303180758380.26753@chaos>
User-Agent: Mutt/1.4i
Organization: Pleyades
User-Agent: Mutt/1.4i <http://www.mutt.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi Richard, again :)

    In my last message I told you that getdtablesize() is not
reliable for closing all file descriptors, that its return value is
not necessarily related to the file descriptor index. Well, I forgot
to say that getdtablehi() effectively returns the index for the
largest file descriptor available to the process plus one, that is,
perfect for using with 'select()' and for closing all open files:

    for(i=0; i<getdtablehi(); i++) close(i);

    Is this implemented under Linux? I have a piece of software that
relies on the above (now it's written using getdtablesize(), which is
non-correct as you noted) for closing all file descriptors...

    Thanks again for noting this, Richard :)

    Raúl Núñez de Arenas Coronado

-- 
Linux Registered User 88736
http://www.pleyades.net & http://www.pleyades.net/~raulnac

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284442AbRLEQRo>; Wed, 5 Dec 2001 11:17:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283770AbRLEQRe>; Wed, 5 Dec 2001 11:17:34 -0500
Received: from zikova.cvut.cz ([147.32.235.100]:54028 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S283786AbRLEQQr>;
	Wed, 5 Dec 2001 11:16:47 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Cyrille Beraud <cyrille.beraud@savoirfairelinux.com>
Date: Wed, 5 Dec 2001 17:15:52 MET-1
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: Removing an executable while it runs
CC: linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.40
Message-ID: <B22D093570E@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On  5 Dec 01 at 11:00, Cyrille Beraud wrote:

> I would like to remove an executable from the file-system while it is 
> running and
> get all the blocks back immediately, not after the end of the program.
> Is this possible ?

No. Binary runs from these blocks. Maybe you can force it to run from
swap by modifying these pages through ptrace interface, but it is
not supported. Just kill the app if you need these blocks.

>  From what I understand, the inode is not released until the program 
> ends. Do all the file-systems behave the same way ?

No. Some will refuse to unlink running app (or another opened file).
Some will unlink it immediately, and app then dies when it needs
page-in something. Some works as POSIX mandates.

                                            Best regards,
                                                Petr Vandrovec
                                                vandrove@vc.cvut.cz
                                                

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271862AbRH1SN4>; Tue, 28 Aug 2001 14:13:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269229AbRH1SNq>; Tue, 28 Aug 2001 14:13:46 -0400
Received: from relay03.cablecom.net ([62.2.33.103]:8458 "EHLO
	relay03.cablecom.net") by vger.kernel.org with ESMTP
	id <S271862AbRH1SNc>; Tue, 28 Aug 2001 14:13:32 -0400
Message-Id: <200108281813.f7SIDjY03688@mail.swissonline.ch>
Content-Type: text/plain; charset=US-ASCII
From: Christian Widmer <cwidmer@iiic.ethz.ch>
Reply-To: cwidmer@iiic.ethz.ch
To: linux-kernel@vger.kernel.org
Subject: does the request function block
Date: Tue, 28 Aug 2001 20:13:45 +0200
X-Mailer: KMail [version 1.3]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

does the request function of a bock device driver to be attomic or may it 
block? in the linux device driver 2 it says that it must be attomic and 
may not block. that makes sense to me since it also sais that the bottom-
half of the driver will call the request function too. but this is not realy
nessesery when i remove all request before releasing the io_request_lock.
on the other side block devices like nbd or brbd do send date using a socket
in there request function.

who is right and why?

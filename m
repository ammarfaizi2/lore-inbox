Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264490AbRFOTOY>; Fri, 15 Jun 2001 15:14:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264493AbRFOTOO>; Fri, 15 Jun 2001 15:14:14 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:27143 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S264490AbRFOTOC>; Fri, 15 Jun 2001 15:14:02 -0400
Subject: Re: Client receives TCP packets but does not ACK
To: mblack@csihq.com (Mike Black)
Date: Fri, 15 Jun 2001 20:12:48 +0100 (BST)
Cc: f.v.heusden@ftr.nl (Heusden Folkert van), linux-kernel@vger.kernel.org
In-Reply-To: <03c701c0f5c8$e15f7e10$e1de11cc@csihq.com> from "Mike Black" at Jun 15, 2001 02:27:47 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15Az1U-0006wI-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> TCP is guaranteed delivery at layer 5 -- but that's all -- not a "guaranteed
> protocol"

For certain specific cases this is in itself not true either. Also for many
many implementations.

Specifically
1.	If the receiver closes and there is unread data many TCP's forget
	to RST the sender to indicate that data was lost.

2.	There is a flaw in the TCP protocol itself that is extremely unlikely
	to bite people but can in theory cause wrong data in some unusual
	circumstances that Ian Heavans found and has yet to be fixed by
	the keepers of the protocol.



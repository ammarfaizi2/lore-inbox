Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130420AbRCEUsI>; Mon, 5 Mar 2001 15:48:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130660AbRCEUr6>; Mon, 5 Mar 2001 15:47:58 -0500
Received: from csa.iisc.ernet.in ([144.16.67.8]:57359 "EHLO csa.iisc.ernet.in")
	by vger.kernel.org with ESMTP id <S130420AbRCEUrs>;
	Mon, 5 Mar 2001 15:47:48 -0500
Date: Tue, 6 Mar 2001 02:17:31 +0530 (IST)
From: Sourav Sen <sourav@csa.iisc.ernet.in>
To: kernelnewbies@humbolt.nl.linux.org, lkml <linux-kernel@vger.kernel.org>
Subject: sk_buff in 2.4.0
Message-ID: <Pine.SOL.3.96.1010306020031.2349A-100000@kohinoor.csa.iisc.ernet.in>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,
	As far as I understand, in 2.2.x networking code the protocol
header and data used to reside in a contiguous region in memory(pointed
to by the head, data, tail, end of sk_buff struct), 
ie skb->data is the starting point and skb->tail is the ending point. 

		        |		|
		        |		|
	skb->data --	|--------------	|
		     	|		|
			|		|
			|		|
			|		|
			|		|
	skb->tail --    |---------------|
			|		|

	And the device drivers used to transfer from skb->data to
skb->tail(==skb->len).

	My question is: Is the state of the art same in 2.4.0, ie. is
protocol header and data still has to reside contiguously? Or header and
data may be non-contiguous and the driver does scatter/gather.

	I am starting off in 2.4.0 , plz. help.

--
sourav
--------------------------------------------------------------------------------
SOURAV SEN    MSc(Engg.) CSA IISc BANGALORE URL : www2.csa.iisc.ernet.in/~sourav 
ROOM NO : N-78      TEL :(080)309-2454(HOSTEL)          (080)309-2906 (COMP LAB) 
--------------------------------------------------------------------------------


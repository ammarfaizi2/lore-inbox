Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270065AbTHLNof (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 09:44:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270325AbTHLNof
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 09:44:35 -0400
Received: from 67.1-254.149.217.200.telemar.net.br ([200.217.149.67]:19893
	"EHLO odin.unimedfortaleza.com.br") by vger.kernel.org with ESMTP
	id S270065AbTHLNod (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 09:44:33 -0400
Date: Tue, 12 Aug 2003 10:49:31 -0300 (BRT)
From: Leonardo Eloy <leonardoeloy@unimedfortaleza.com.br>
X-X-Sender: leonardoeloy@localhost.localdomain
To: linux-kernel@vger.kernel.org
cc: tim@cyberelk.net, <torvalds@home.osdl.org>
Subject: patch: Parallel Port IDE Driver, kernel: 2.6.0-test3
Message-ID: <Pine.LNX.4.44.0308121040150.13990-101000@localhost.localdomain>
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on odin/Unimedfor(Release 5.0.11 |July 24, 2002) at
 08/12/2003 10:46:28 PM,
	Serialize by Router on odin/Unimedfor(Release 5.0.11 |July 24, 2002) at 08/12/2003
 10:46:34 PM
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-949891457-1060696171=:13990"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--8323328-949891457-1060696171=:13990
Content-Type: TEXT/PLAIN; charset=US-ASCII

	Parallel Port IDE driver compilation error - driver/block/paride/pd.c
	In 2.4 the function blk_init_queue() in drivers/block/ll_rw_blk.c, received the request_queue_t and the 
request_fn_proc pointers and returned nothing (void). The 2.6 kernel updated this function so it can receive the 
request_fn_proc and spinlock_t, returning the request_queue_t pointer.
	The driver hasn't implemented the new function yet, that's what the patch does.


Leonardo Eloy <leonardoeloy@unimedfortaleza.com.br>
- driver/block/paride/pd.c: fixed blk_init_queue() call and the pd_queue variable


(patch follows as attachment)

--8323328-949891457-1060696171=:13990
Content-Type: APPLICATION/x-gzip; name="pport_ide_driver.patch.gz"
Content-ID: <Pine.LNX.4.44.0308121049310.13990@localhost.localdomain>
Content-Description: 
Content-Disposition: attachment; filename="pport_ide_driver.patch.gz"
Content-Transfer-Encoding: base64

H4sICBAHOD8AA3Bwb3J0X2lkZV9kcml2ZXIucGF0Y2gAjZNba9swFICf419xFuiwZ7uxk67NhZbA
Gkaha8vK9jQQqqUGLYmsSnJoGfvvO5Lt1L0ygy35XKTv3NI0hbWQ1f2AabHl2gxu1mWxGiiqBeMD
xfaL3jDLRmk2TrMJZPl0NJmODvez9oE0G2VZEMcxbITk+/97WJ5DPp5mB9NR/uKw+RzSw88HyRHE
9TKfB9DT3FZagmIED5NW3D6ETJhVNAvgbwBBaiy1ogBjdVVY0Pyu4sYS/FbcOfnNLIjfM/v0aAcB
NJZCWufPuOWFDbelYFEAfzzkUeYh68VD9nqGW1JQRQthH0KVgGNMT1qJo0WjWrhkcAyqlqj0RGHS
qOWEUUtR4WxmQVrrar5j+NiJ5Kmmg44KypAYDwhVfSNmCF/PPB56Zr94ZqOEJK5QROg7Q7c8dLc4
QQLul5HbNV0afxCXjDQ5C5Xfok1VFNzUepTdVOYBeTLHzkqiHh128JGjf6rrqBqiSrZMGg1K/Q6W
q7+LbTwZJfkIYr820YlbCDVfCmO5JjfrFePbcEN/lzoBSTc8ilx6mt5Kc1f4tIdmREjRtMUjN1az
C51ASxTNGi9vRjb0nhjsllKbrnOxrhyFj76VYqae3fb2FbEP5sMuVa4FlqUtoZIYYROcbwx8X6d5
DQZc3TS2+Srs75kp7BlwwytKidsEfLJgj+1c/F6KguPml+wn6A714xKaNN+rU/Jz8f367PKiOWLn
Xzu37eIjr/BjQi9qQ2zmLYpw1uJugFNXMC94s6az5zVten8yzFzvT4adeVUCc73m1PCwnkoluiNT
l7VAA1mp5/3ga/JS3+1l15rw7fL0x/mCnJ99WVxcL8L+16vzPir/AWysVDl9BQAA

--8323328-949891457-1060696171=:13990--

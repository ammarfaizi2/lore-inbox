Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264815AbTBEUUQ>; Wed, 5 Feb 2003 15:20:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264836AbTBEUUQ>; Wed, 5 Feb 2003 15:20:16 -0500
Received: from 200-181-159-001.ctame7025.dsl.brasiltelecom.net.br ([200.181.159.1]:46977
	"EHLO PolesApart.wox.org") by vger.kernel.org with ESMTP
	id <S264815AbTBEUUN>; Wed, 5 Feb 2003 15:20:13 -0500
Message-ID: <3E417430.9000101@PolesApart.dhs.org>
Date: Wed, 05 Feb 2003 18:29:36 -0200
From: Alexandre Pereira Nunes <alex@PolesApart.dhs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pt-BR; rv:1.2.1) Gecko/20021130
X-Accept-Language: pt-br, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: kraxel@bytesex.org
Subject: promiscuous bttv parameter checking (2.4.21-pre3)
X-Enigmail-Version: 0.71.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

As of linux 2.4.21-pre3, bttv driver fails to check the "channel" 
attribute correctly. This is caused because there is no check for 
negative values on the  channel parameter (at least ) in ioctls 
VIDIOCGCHAN (bttv-driver.c:1510) and VIDIOCSCHAN (same file, at line 
1537). Negative parameters, though invalid, are passed along.

While in the first case (VIDIOCGCHAN) I see no dark effects other than 
the wacky channel name in the name member of the returned structure, it 
is possible that passing the negative value in VIDIOCSCHAN spots 
side-effects, specially in the function bt848_muxsel.


(A cc: went to the maintainer. Any questions please cc: me since I'm not 
subscribed to the kernel mailing list).


Best regards,


Alexandre



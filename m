Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277306AbRJRAXD>; Wed, 17 Oct 2001 20:23:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277313AbRJRAWx>; Wed, 17 Oct 2001 20:22:53 -0400
Received: from tartarus.telenet-ops.be ([195.130.132.34]:30169 "EHLO
	tartarus.telenet-ops.be") by vger.kernel.org with ESMTP
	id <S277306AbRJRAWj>; Wed, 17 Oct 2001 20:22:39 -0400
Message-ID: <3BCE1E54.D14794A5@pandora.be>
Date: Thu, 18 Oct 2001 02:12:04 +0200
From: johan verrept <johan.verrept@pandora.be>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@transmeta.com>, alan cox <alan@redhat.com>
Subject: [PATCH] (Minor) Bugfixes to vsprintf.c, vsscanf().
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


hello,

minor bugfix for vsprintf.c, vsscanf did not discard whitespace in input:
- when encoutering whitespace in fmt not followed by '%'
- in conversion where result is ignored with '*'

There is another bugfix in this, don't know from who. (picked it up with uml)
(vsscanf used to skip two characters in the fmt for a single char in the input if not in
conversion.)

Patch against 2.4.12, I am afraid.

enjoy,

	J.

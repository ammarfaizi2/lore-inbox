Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129154AbRBOTdj>; Thu, 15 Feb 2001 14:33:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129373AbRBOTd2>; Thu, 15 Feb 2001 14:33:28 -0500
Received: from unimur.um.es ([155.54.1.1]:32192 "EHLO unimur.um.es")
	by vger.kernel.org with ESMTP id <S129319AbRBOTdP>;
	Thu, 15 Feb 2001 14:33:15 -0500
Message-ID: <3A8C333D.FA59D477@ditec.um.es>
Date: Thu, 15 Feb 2001 20:51:25 +0100
From: Juan <piernas@ditec.um.es>
X-Mailer: Mozilla 4.76 [es] (X11; U; Linux 2.4.2-pre3 i686)
X-Accept-Language: es-ES, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, Remy.Card@linux.org
Subject: [ONE-LINE PATCH](Silly?) bug in ext2/namei.c, 2.2.x, 2.4.x
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I think that this is a bug. The buffer is always released except in this
case.

Bye.

----------------------------------------------------
*** /usr/src/linux-2.4.1/fs/ext2/namei.c        Tue Dec 12 16:48:22 2000
--- namei.c.new Thu Feb 15 20:42:45 2001
***************
*** 235,240 ****
--- 235,241 ----
                                return retval;
                        if (dir->i_size <= offset) {
                                if (dir->i_size == 0) {
+                                       brelse(bh);
                                        return -ENOENT;
                                }
----------------------------------------------------
-- 
D. Juan Piernas Cánovas
Departamento de Ingeniería y Tecnología de Computadores
Facultad de Informática. Universidad de Murcia
Campus de Espinardo - 30080 Murcia (SPAIN)
Tel.: +34968367657    Fax: +34968364151
email: piernas@ditec.um.es
PGP public key:
http://pgp.rediris.es:11371/pks/lookup?search=piernas%40ditec.um.es&op=index

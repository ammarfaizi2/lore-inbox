Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263548AbUDMLE0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Apr 2004 07:04:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263544AbUDMLEZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Apr 2004 07:04:25 -0400
Received: from matrix.roma2.infn.it ([141.108.255.2]:42671 "EHLO
	matrix.roma2.infn.it") by vger.kernel.org with ESMTP
	id S263551AbUDMLEX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Apr 2004 07:04:23 -0400
From: "Emiliano 'AlberT' Gabrielli" <AlberT@SuperAlberT.it>
Reply-To: AlberT@SuperAlberT.it
Organization: SuperAlberT.it
To: linux-kernel@vger.kernel.org
Subject: [TRIVIAL PATCH] make Documentation
Date: Tue, 13 Apr 2004 13:02:17 +0200
User-Agent: KMail/1.6.1
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Message-Id: <200404131304.21080.AlberT@SuperAlberT.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

makeing docs raise this error:

Using stylesheet: /usr/share/sgml/docbook/utils-0.6.13/docbook-utils.dsl#html
Working on: /usr/src/linux-2.6.5/Documentation/DocBook/parportbook.sgml
openjade:/usr/src/linux-2.6.5/Documentation/DocBook/parportbook.sgml:4059:2:E: 
invalid comment declaration: found character "!" outside comment but inside 
comment declaration
openjade:/usr/src/linux-2.6.5/Documentation/DocBook/parportbook.sgml:4058:0: 
comment declaration started here
openjade:/usr/src/linux-2.6.5/Documentation/DocBook/parportbook.sgml:4059:4:E: 
character data is not allowed here
make[3]: *** [Documentation/DocBook/parportbook.html] Error 8
make[2]: *** [htmldocs] Error 2
make[2]: Leaving directory `/usr/src/linux-2.6.5'
make[1]: *** [real_stamp_doc] Error 2
make[1]: Leaving directory `/usr/src/linux-2.6.5'
make: *** [stamp-doc] Error 2


this trivial patch solves the problem, plz apply:

#####################################################

- --- /usr/src/linux-2.6.5/Documentation/DocBook/parportbook.sgml.orig    
2004-04-13 12:59:21.000000000 +0200
+++ /usr/src/linux-2.6.5/Documentation/DocBook/parportbook.sgml 2004-04-13 
12:59:50.000000000 +0200
@@ -4056,7 +4056,7 @@

 </book>
 <!-- Additional function to be documented:
- ---! Ddrivers/parport/init.c (this file doesn't exist any more)
+   drivers/parport/init.c (this file doesn't exist any more)
 -->
 <!-- Local Variables: -->
 <!-- sgml-indent-step: 1 -->

#####################################################

- -- 
<?php echo '       Emiliano `AlberT` Gabrielli       '."\n".
           '  E-Mail: AlberT_AT_SuperAlberT_it  '."\n".
           '  Web:    http://SuperAlberT.it  '."\n".
'  IRC:    #php,#AES azzurra.com '."\n".'ICQ: 158591185'; ?>
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAe8jFF4boRkzPHocRAvPmAKCAmMvZbQfZWYE5hWnwAI/pL8PCfgCgiJ5C
8t2eXfAqfILvuBNwJGzumj8=
=RfVI
-----END PGP SIGNATURE-----

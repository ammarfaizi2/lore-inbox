Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263428AbTGBQ4E (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jul 2003 12:56:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264104AbTGBQ4D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jul 2003 12:56:03 -0400
Received: from [65.248.4.67] ([65.248.4.67]:8379 "EHLO verdesmares.com")
	by vger.kernel.org with ESMTP id S263428AbTGBQ4A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jul 2003 12:56:00 -0400
Message-ID: <001801c340bc$a8f0f9a0$19dfa7c8@bsb.virtua.com.br>
From: "Breno" <brenosp@brasilsec.com.br>
To: "Kernel List" <linux-kernel@vger.kernel.org>
References: <000701c340bb$e48b43e0$19dfa7c8@bsb.virtua.com.br>
Subject: Re: about send task[txt]
Date: Wed, 2 Jul 2003 14:09:10 -0300
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0013_01C340A3.82233C20"
X-XTmail: http://www.verdesmares.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_0013_01C340A3.82233C20
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

Sorry , the body of this mail was not good

please , see the .txt file


thanks

------=_NextPart_000_0013_01C340A3.82233C20
Content-Type: text/plain;
	name="process_migration.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="process_migration.txt"

the idea to transfer a simples task is:



Thread1 in NODE A    <-------TCP CONN----------->   Thread2 in NODE B
__________________				     __________________

- select task by pid			              -verify the availability  of these =
virtual addresses.
						      if it busy , free the memory of these virtual addresses.
- get structs mm , vma , task , zone , page					     =20
  and copy all buffers existing in the =09
  memory.	    				       -alloc all the buffer of task.
 		      				=09
						=09
- send all buffers to thread2			     -re-build structs =
(alloc_task_struct,page_zone,pte_page...)
 					    =20
						     -INIT_LIST_HEAD()
						    =20
						     -wake_up_process()
-send all virtual addresses to thread2



Breno
------=_NextPart_000_0013_01C340A3.82233C20--


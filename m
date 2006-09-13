Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751573AbWIMFka@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751573AbWIMFka (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 01:40:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751578AbWIMFk3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 01:40:29 -0400
Received: from exprod6og51.obsmtp.com ([64.18.1.183]:64683 "HELO
	exprod6og51.obsmtp.com") by vger.kernel.org with SMTP
	id S1751572AbWIMFk2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 01:40:28 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.6603.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Subject: AW: fix 2.4.33.3 / sun partition size
Date: Wed, 13 Sep 2006 07:40:26 +0200
Message-ID: <DA6197CAE190A847B662079EF7631C06015692C6@OEKAW2EXVS03.hbi.ad.harman.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: fix 2.4.33.3 / sun partition size
Thread-Index: AcbWoSvqPVu9Yx2SQ3+AiSox8VhdywAVSOWw
From: "Jurzitza, Dieter" <DJurzitza@harmanbecker.com>
To: "Willy Tarreau" <w@1wt.eu>
Cc: <linux-kernel@vger.kernel.org>, "Jeff Mahoney" <jeffm@suse.com>,
       <sparclinux@vger.kernel.org>, <davem@davemloft.net>
X-OriginalArrivalTime: 13 Sep 2006 05:40:26.0523 (UTC) 
    FILETIME=[1D678EB0:01C6D6F7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Willy,
one final thougth here: ist there any real reason to *not* make
add_gd_partition (struct gendisk, int minor, unsigned long start, unsigned long size){...}
(see fs/partitions/check.c)
as:

- within add_gd_partition the two values start and size are assigned to a field of type unsigned long,
- we both agree that there is no reason to use signed ints in this case,
- any byte size conversion issue would be covered by the fact that it does not hurt assigning too small numbers to oversized ones.

Just my two cents here ...

Take care




Dieter


-- 
________________________________________________

HARMAN BECKER AUTOMOTIVE SYSTEMS

Dr.-Ing. Dieter Jurzitza
Manager Hardware Systems
   System Development

Industriegebiet Ittersbach
Becker-Göring Str. 16
D-76307 Karlsbad / Germany

Phone: +49 (0)7248 71-1577
Fax:   +49 (0)7248 71-1216
eMail: DJurzitza@harmanbecker.com
Internet: http://www.becker.de
 


*******************************************
Diese E-Mail enthaelt vertrauliche und/oder rechtlich geschuetzte Informationen. Wenn Sie nicht der richtige Adressat sind oder diese E-Mail irrtuemlich erhalten haben, informieren Sie bitte sofort den Absender und loeschen Sie diese Mail. Das unerlaubte Kopieren sowie die unbefugte Weitergabe dieser Mail ist nicht gestattet.
 
This e-mail may contain confidential and/or privileged information. If you are not the intended recipient (or have received this e-mail in error) please notify the sender immediately and delete this e-mail. Any unauthorized copying, disclosure or distribution of the contents in this e-mail is strictly forbidden.
*******************************************


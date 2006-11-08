Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754635AbWKHSCE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754635AbWKHSCE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 13:02:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754638AbWKHSCC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 13:02:02 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:14235 "EHLO
	out1.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S1754635AbWKHSCA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 13:02:00 -0500
X-Sasl-enc: 4ElHB19IZGSbVgZHFONf3o1kFP6ciJ6FSjhwdE5SLFYR 1163008920
Date: Wed, 8 Nov 2006 16:01:54 -0200
From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
To: Michael Holzheu <holzheu@de.ibm.com>
Cc: pavel@ucw.cz, Ingo Oeser <ioe-lkml@rameria.de>,
       linux-kernel@vger.kernel.org, mschwid2@de.ibm.com
Subject: Re: How to document dimension units for virtual files?
Message-ID: <20061108180154.GC15063@khazad-dum.debian.net>
References: <20061108175412.3c2be30c.holzheu@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061108175412.3c2be30c.holzheu@de.ibm.com>
X-GPG-Fingerprint: 1024D/1CDB0FE3 5422 5C61 F6B7 06FB 7E04  3738 EE25 DE3F 1CDB 0FE3
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 08 Nov 2006, Michael Holzheu wrote:
> +- If data has dimension units, encode that in the filename.

Can we please encode units in the filename using a separator other than "_"?
the reason for this is that _ is already_used_to_separate_words in the
entries, and it gets difficult to know if something is part of the entry
name or an unit.

Please consider using ":" to separate units and other specific qualifiers
(e.g. led colors) from the main attribute name.  This helps userspace
applications to behave better when faced with stuff like "a_b_c:unit1" and
"a_b_c:unit2" at the same time.

That said, AFAIK using units is explicitly discouraged on hwmon-style sysfs
classes.  The recent thread about a battery class illustrates this.  Please
keep this in mind.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh

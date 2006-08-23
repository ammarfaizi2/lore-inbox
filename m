Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751465AbWHWJOf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751465AbWHWJOf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 05:14:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751466AbWHWJOf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 05:14:35 -0400
Received: from mail.gmx.net ([213.165.64.20]:42628 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751465AbWHWJOe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 05:14:34 -0400
Content-Type: text/plain; charset="iso-8859-1"
Date: Wed, 23 Aug 2006 11:14:33 +0200
From: "Gerhard Pircher" <gerhard_pircher@gmx.net>
Message-ID: <20060823091433.316970@gmx.net>
MIME-Version: 1.0
Subject: Question about aper_size_info structs in agp.h
To: linux-kernel@vger.kernel.org
X-Authenticated: #6097454
X-Flags: 0001
X-Mailer: WWW-Mail 6100 (Global Message Exchange)
X-Priority: 3
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I was wondering about the differences between the aperture size types defined in agp.h. As far as I understand the size_value field in the aper_size_info_8/16/32 structs just defines the value to be set in the AGP bridge registers to configure a specific AGP aperture size (e.g. 8 MB, 16MB, etc..).

Wouldn't it be sufficient to define size_value as 32 bit only, or does the type of size_value/aper_size_info_x have an influence on the generation of the graphics address remapping table (e.g. address alignment) ?

For example the uninorth driver uses the aper_size_info_32 struct to define the AGP aperture size, but only defines values between 1 and 64 for the size_value field (so aper_size_info_8 would be sufficient).

BTW: Can anybody explain the format of the graphics address remapping table or point me to some docs where it is described?

regards,

Gerhard

-- 


Der GMX SmartSurfer hilft bis zu 70% Ihrer Onlinekosten zu sparen!
Ideal für Modem und ISDN: http://www.gmx.net/de/go/smartsurfer

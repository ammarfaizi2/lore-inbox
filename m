Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750971AbWKBMqd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750971AbWKBMqd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 07:46:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750945AbWKBMqd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 07:46:33 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:21079 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1750716AbWKBMqc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 07:46:32 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=lcMYyk0moILDqJCFPKF8PZqHKE4/Tisu5ydB8kcHkDumuWJtcPFCT27fKTzySSfB5vcWymyrCBvUbjUuDgHzBM5RjcqmZXyA8j7QpKEfMAABBVJg8Je4VsJigqULF2St9CTfDKv7k6JE6WdyI89eGdgLK9U19+b2yZx66ywYRkY=
Message-ID: <a86d33430611020446s135b07ffjcdb9a6278e83d9e5@mail.gmail.com>
Date: Thu, 2 Nov 2006 13:46:30 +0100
From: "Jan Peter den Heijer" <jpdenheijer@gmail.com>
To: "Oleg Verych" <olecom@flower.upol.cz>
Subject: Re: [PATCH -mm] replacement for broken kbuild-dont-put-temp-files-in-the-source-tree.patch
Cc: "Horst Schirmeier" <horst@schirmeier.com>, "Andi Kleen" <ak@suse.de>,
       Valdis.Kletnieks@vt.edu, "Jan Beulich" <jbeulich@novell.com>,
       dsd@gentoo.org, kernel@gentoo.org, draconx@gmail.com,
       "Andrew Morton" <akpm@osdl.org>, "Sam Ravnborg" <sam@ravnborg.org>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20061031135136.GB16063@flower.upol.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061029120858.GB3491@quickstop.soohrt.org>
	 <slrnekcu6m.2vm.olecom@flower.upol.cz>
	 <20061031001235.GE2933@quickstop.soohrt.org>
	 <200610310119.10567.ak@suse.de>
	 <20061031011416.GG2933@quickstop.soohrt.org>
	 <20061031135136.GB16063@flower.upol.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

How about using this:

ASTMP := $(if $(KBUILD_EXTMOD),$(firstword $(KBUILD_EXTMOD))/)astest$$$$.out

This is also used in the Makefile in the source tree top-level
directory (see line 332)
If KBUILD_EXTMOD is used, temp files are created in the module's
source directory, otherwise in the kernel source top-level directory

Jan Peter

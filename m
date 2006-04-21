Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932312AbWDUN4Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932312AbWDUN4Y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 09:56:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932311AbWDUN4Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 09:56:24 -0400
Received: from mtagate4.de.ibm.com ([195.212.29.153]:57472 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP id S932316AbWDUN4X
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 09:56:23 -0400
In-Reply-To: <84144f020604210453w186f20a4s3d163c395364e87e@mail.gmail.com>
Subject: Re: [PATCH/RFC] s390: Hypervisor File System
To: "Pekka Enberg" <penberg@cs.helsinki.fi>
Cc: linux-kernel@vger.kernel.org, mschwid2@de.ibm.com, penberg@gmail.com
X-Mailer: Lotus Notes Build V70_M4_01112005 Beta 3NP January 11, 2005
Message-ID: <OF88396E73.9225D435-ON42257157.004BB28F-42257157.004C9411@de.ibm.com>
From: Michael Holzheu <HOLZHEU@de.ibm.com>
Date: Fri, 21 Apr 2006 15:56:26 +0200
X-MIMETrack: Serialize by Router on D12ML061/12/M/IBM(Release 6.53HF654 | July 22, 2005) at
 21/04/2006 15:57:22
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pekka,

> This filesystem makes no sense for anything but s390 so please put it
> under arch/s390/ (following the convention set by cell specific
> spufs). Thanks.

Agreed! As long as the filesystem is s390 specifc, we probably should put
it put it under arch/s390/hypfs. But in general one could imagine, that
also other hypervisor platforms want to have such a filesystem in the
future. In that case, we could make the filesystem more generic. E.g. we
could split it into the filesystem part and an architecture specific
backend which provides the hypervisor data. But you are right, until no
other platform supports it, we should keep it simple, leave it s390
specific and move it to arch/s390.

Michael


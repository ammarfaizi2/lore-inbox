Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751744AbWCCWeh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751744AbWCCWeh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 17:34:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751745AbWCCWeh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 17:34:37 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:6581 "EHLO e34.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750982AbWCCWeg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 17:34:36 -0500
From: Kevin Corry <kevcorry@us.ibm.com>
Organization: IBM
To: linux-kernel@vger.kernel.org
Subject: Re: is there a COW inside the kernel ?
Date: Fri, 3 Mar 2006 16:39:58 -0600
User-Agent: KMail/1.8.3
Cc: "roland" <devzero@web.de>
References: <043101c63e9c$86e9d710$0200000a@aldipc> <200603030828.59567.kevcorry@us.ibm.com> <04cd01c63f09$a007a930$0200000a@aldipc>
In-Reply-To: <04cd01c63f09$a007a930$0200000a@aldipc>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603031639.58616.kevcorry@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri March 3 2006 3:29 pm, roland wrote:
> i think i will take a closer look on device-mapper, but i'm unsure if it`s
> perfectly suited.
>
> can i only use devices, not files for the cow?

Yes, Device-Mapper can only map to block-devices. If you need to do this with 
files, you could use losetup to create block-device from them. However, the 
COW device still won't "grow" automatically as you described.

> what about merging a cow-dev/file back to the r/o-dev/file ?

Device-Mapper does not directly support this, but EVMS provides a "rollback" 
function for reverting an origin volume back to the contents of its snapshot 
volume.

-- 
Kevin Corry
kevcorry@us.ibm.com
http://www.ibm.com/linux/
http://evms.sourceforge.net/

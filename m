Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262750AbTJPIFM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Oct 2003 04:05:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262753AbTJPIFM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Oct 2003 04:05:12 -0400
Received: from twilight.cs.hut.fi ([130.233.40.5]:6815 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP id S262750AbTJPIFE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Oct 2003 04:05:04 -0400
Date: Thu, 16 Oct 2003 11:04:46 +0300
From: Ville Herva <vherva@niksula.hut.fi>
To: Tomas Szepe <szepe@pinerecords.com>
Cc: Erik Mouw <erik@harddisk-recovery.com>,
       Nikita Danilov <Nikita@Namesys.COM>, Josh Litherland <josh@temp123.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Transparent compression in the FS
Message-ID: <20031016080446.GF4868@niksula.cs.hut.fi>
Mail-Followup-To: Ville Herva <vherva@niksula.cs.hut.fi>,
	Tomas Szepe <szepe@pinerecords.com>,
	Erik Mouw <erik@harddisk-recovery.com>,
	Nikita Danilov <Nikita@Namesys.COM>,
	Josh Litherland <josh@temp123.org>, linux-kernel@vger.kernel.org
References: <1066163449.4286.4.camel@Borogove> <20031015133305.GF24799@bitwizard.nl> <16269.20654.201680.390284@laputa.namesys.com> <20031015142738.GG24799@bitwizard.nl> <20031015213624.GA29472@louise.pinerecords.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031015213624.GA29472@louise.pinerecords.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 15, 2003 at 11:36:24PM +0200, you [Tomas Szepe] wrote:
> On Oct-15 2003, Wed, 16:27 +0200
> Erik Mouw <erik@harddisk-recovery.com> wrote:
> 
> > You have a point, but remember that modern IDE drives can do about
> > 50MB/s from medium. I don't think you'll find a CPU that is able to
> > handle transparent decompression on the fly at 50MB/s ... [snip]
> 
> You may want to check out LZO performance on a recent CPU.
> http://www.oberhumer.com/opensource/lzo/

Out of interest:

Celeron 1.4GHz, a source tar:

           compr MB/s uncompr MB/s ratio
lzo -m71:  58.2       170.2        24.4%
lzo -m972:  2.7       100.8        17.7%

gzip -1:   13.6       115.7        22.1%
gzip -6:    8.8       121.8        17.7%
gzip -9:    4.5        79.8        17.6%

lzo used assembler versions.


-- v --

v@iki.fi

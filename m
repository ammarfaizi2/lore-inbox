Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261360AbTEMO42 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 10:56:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261358AbTEMO42
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 10:56:28 -0400
Received: from carisma.slowglass.com ([195.224.96.167]:30472 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S261308AbTEMO4T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 10:56:19 -0400
Date: Tue, 13 May 2003 16:09:02 +0100
From: "'Christoph Hellwig'" <hch@infradead.org>
To: "Mukker, Atul" <atulm@lsil.com>
Cc: "'Mike Anderson'" <andmike@us.ibm.com>, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: unique entry points for all driver hosts
Message-ID: <20030513160902.A26759@infradead.org>
Mail-Followup-To: 'Christoph Hellwig' <hch@infradead.org>,
	"Mukker, Atul" <atulm@lsil.com>,
	'Mike Anderson' <andmike@us.ibm.com>, linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <0E3FA95632D6D047BA649F95DAB60E570185F196@EXA-ATLANTA.se.lsil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <0E3FA95632D6D047BA649F95DAB60E570185F196@EXA-ATLANTA.se.lsil.com>; from atulm@lsil.com on Tue, May 13, 2003 at 09:43:52AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 13, 2003 at 09:43:52AM -0400, Mukker, Atul wrote:
> IMHO, declaring multiple SHTs as suggested by Christoph Hellwig may not be a
> good idea since it might appear like a hack, would lose the "template"
> ideology and is not object-oriented :-)

The linux kernel is a pragmatic mix of procedural and object oriented
concepts, if you want ideology please look elsewhere.  The template is
exactly a template for multiple hosts and if you driver supports different
enouigh boards you need multiple templates - it's pretty simple.  Not that
the template is used much at all..

> Host structure would be best place to have pointers to these hooks as well.

This is right but not how the linux scsi stack was written.  Removing them
now causes more pain then it would solve - just live with the extra indirection.


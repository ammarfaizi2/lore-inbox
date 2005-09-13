Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932692AbVIMUAR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932692AbVIMUAR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 16:00:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932695AbVIMUAR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 16:00:17 -0400
Received: from wproxy.gmail.com ([64.233.184.200]:3162 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932694AbVIMUAP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 16:00:15 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=TITsCt7XrS7gMrusrPRfNUsnJSvZKIaGn8suWw35uN8/Nrr88WJYFYIh69jX9zELHTK7rvPYPXMoI2VDLnIAg+Dreck5RGnLMwzaUxM0owUFZORHQz7uK7ardMsjrVQKmEXV1kBgGfZK4M4eKLWcT5rL07A0l2hatbBsnkWaEtk=
Date: Wed, 14 Sep 2005 00:10:16 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Josh Boyer <jdub@us.ibm.com>
Cc: Brian Gerst <bgerst@didntduck.org>,
       Russell King <rmk+lkml@arm.linux.org.uk>,
       Joern Engel <joern@infradead.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Permanently fix kernel configuration include mess
Message-ID: <20050913201016.GA6776@mipter.zuzino.mipt.ru>
References: <20050913135622.GA30675@phoenix.infradead.org> <20050913150825.A23643@flint.arm.linux.org.uk> <20050913155012.C23643@flint.arm.linux.org.uk> <20050913165954.GA31461@phoenix.infradead.org> <20050913190409.B26494@flint.arm.linux.org.uk> <4327242B.5050806@didntduck.org> <1126639985.3209.9.camel@windu.rchland.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1126639985.3209.9.camel@windu.rchland.ibm.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 13, 2005 at 02:33:04PM -0500, Josh Boyer wrote:
> That could probably be done in a later cleanup patch that removes all
> "#include <linux/config.h>" statements as well.  Sounds like a job for
> the kernel janitors project.

Only after -imacros will hit mainline. For now, it's a "cleanup "make
checkconfig" output".

BTW, somebody who'll send a final patch, please, ensure that "make C=1"
doesn't blow up. Grepping for "macros" on sparse codebase show nothing.


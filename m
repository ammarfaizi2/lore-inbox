Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261845AbTEYLKf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 May 2003 07:10:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261847AbTEYLKf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 May 2003 07:10:35 -0400
Received: from pub237.cambridge.redhat.com ([213.86.99.237]:40385 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id S261845AbTEYLKe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 May 2003 07:10:34 -0400
Subject: Re: [RFC][2.5] generic_usercopy() function (resend, forgot the
	patches)
From: David Woodhouse <dwmw2@infradead.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Michael Hunold <hunold@convergence.de>, linux-kernel@vger.kernel.org
In-Reply-To: <20030523104722.B15725@infradead.org>
References: <3ECDEBC5.5030608@convergence.de>
	 <20030523104722.B15725@infradead.org>
Content-Type: text/plain
Organization: 
Message-Id: <1053861820.2082.36.camel@passion.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5.dwmw2) 
Date: Sun, 25 May 2003 12:23:40 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-05-23 at 10:47, Christoph Hellwig wrote:
> > +	err = func(inode, file, cmd, parg);
> > +	if (err == -ENOIOCTLCMD)
> > +		err = -EINVAL;
> 
> I don't think this is the right place for this substitution - leave it to
> the drivers.

And make it -ENOTTY. -EINVAL is not correct for unknown ioctls.

-- 
dwmw2


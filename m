Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751332AbWDESxb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751332AbWDESxb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Apr 2006 14:53:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751333AbWDESxa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Apr 2006 14:53:30 -0400
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:10385
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1751332AbWDESxa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Apr 2006 14:53:30 -0400
Date: Wed, 5 Apr 2006 11:52:43 -0700
From: Greg KH <greg@kroah.com>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Sergey Vlasov <vsu@altlinux.ru>, gregkh@suse.de,
       linux-kernel@vger.kernel.org, stable@kernel.org
Subject: Re: [stable] Re: [patch 03/26] sysfs: zero terminate sysfs write buffers (CVE-2006-1055)
Message-ID: <20060405185243.GD2577@kroah.com>
References: <20060404235634.696852000@quad.kroah.org> <20060404235947.GD27049@kroah.com> <20060405190928.17b9ba6a.vsu@altlinux.ru> <9e4733910604050830x2daf2ec1vd1fe16073b51de8c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e4733910604050830x2daf2ec1vd1fe16073b51de8c@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 05, 2006 at 11:30:54AM -0400, Jon Smirl wrote:
> 
> The one attribute per file model doesn't work well when the attributes
> need to be changed in a transaction. For example you want to change
> your display to 1024x768 16bit color.  As you set the attributes one
> at a time the display has to change since there is not guarantee that
> you will complete the sequence. The framebuffer sysfs interface breaks
> the one attribute per file rule and uses strings for grouped
> attributes.

I suggest you use configfs instead for this.  It allows this kind of
"grouped attributes".

good luck,

greg k-h

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277277AbRJLKEN>; Fri, 12 Oct 2001 06:04:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277298AbRJLKED>; Fri, 12 Oct 2001 06:04:03 -0400
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:25118 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S277277AbRJLKDt>; Fri, 12 Oct 2001 06:03:49 -0400
Date: Fri, 12 Oct 2001 06:04:20 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Modutils 2.5 change, start running this command now
Message-ID: <20011012060419.A1649@redhat.com>
In-Reply-To: <25612.1002800758@ocs3.intra.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <25612.1002800758@ocs3.intra.ocs.com.au>; from kaos@ocs.com.au on Thu, Oct 11, 2001 at 09:45:58PM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 11, 2001 at 09:45:58PM +1000, Keith Owens wrote:
> In current modutils, a module that does not export symbols and does not
> say EXPORT_NO_SYMBOLS will default to exporting all symbols.  This is a
> hangover from kernel 2.0 and will be removed when modutils 2.5 appears,
> shortly after the kernel 2.5 branch is created.
> 
> Starting with modutils 2.5, modules must explicitly say what their
> intention is for symbols.  That will break a lot of existing modules.

Isn't EXPORT_NO_SYMBOLS the default case for 99.44% of modules?  It seems 
to me that the lameness incurred in adding an EXPORT_NO_SYMBOLS line to 
each and every driver that one writes is a pointless additional hoop to 
jump through.  I'd rather break the modules that are relying on behaviour 
that was deprecated several *years* ago than go through another make-work 
project.

		-ben

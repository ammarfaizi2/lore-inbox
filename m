Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277243AbRJLGeN>; Fri, 12 Oct 2001 02:34:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277252AbRJLGeC>; Fri, 12 Oct 2001 02:34:02 -0400
Received: from asterix.hrz.tu-chemnitz.de ([134.109.132.84]:8115 "EHLO
	asterix.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S277243AbRJLGdx>; Fri, 12 Oct 2001 02:33:53 -0400
Date: Fri, 12 Oct 2001 08:34:23 +0200
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Modutils 2.5 change, start running this command now
Message-ID: <20011012083423.M30515@nightmaster.csn.tu-chemnitz.de>
In-Reply-To: <25612.1002800758@ocs3.intra.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <25612.1002800758@ocs3.intra.ocs.com.au>; from kaos@ocs.com.au on Thu, Oct 11, 2001 at 09:45:58PM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 11, 2001 at 09:45:58PM +1000, Keith Owens wrote:
> In current modutils, a module that does not export symbols and does not
> say EXPORT_NO_SYMBOLS will default to exporting all symbols.  This is a
> hangover from kernel 2.0 and will be removed when modutils 2.5 appears,
> shortly after the kernel 2.5 branch is created.
 
Will it still be done, if we put it on the "export-objs" list?

Putting an explicit "EXPORT_SYMBOL(foo)" only encourages people
not to look what they can prepend with "static". Everything not
static is the C-definition of "exporting".

EXPORT_SYMBOL is nice, if you have modules consisting of multiple
objects, that need to share variables/functions but should not be
needed, if the module-author knows sth. about proper design.

Regards

Ingo Oeser

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263003AbSJBI6f>; Wed, 2 Oct 2002 04:58:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263004AbSJBI6f>; Wed, 2 Oct 2002 04:58:35 -0400
Received: from k100-28.bas1.dbn.dublin.eircom.net ([159.134.100.28]:34313 "EHLO
	corvil.com.") by vger.kernel.org with ESMTP id <S263003AbSJBI6f>;
	Wed, 2 Oct 2002 04:58:35 -0400
Message-ID: <3D9AB638.60209@corvil.com>
Date: Wed, 02 Oct 2002 10:02:48 +0100
From: Padraig Brady <padraig.brady@corvil.com>
Organization: Corvil Networks
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020827
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Willy Tarreau <willy@w.ods.org>
CC: Miroslav Rudisin <miero@atrey.karlin.mff.cuni.cz>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] default file permission for vfat
References: <20021001173908.GA15838@atrey.karlin.mff.cuni.cz> <20021001185526.GA704@alpha.home.local>
X-Enigmail-Version: 0.65.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Willy Tarreau wrote:
> On Tue, Oct 01, 2002 at 07:39:08PM +0200, Miroslav Rudisin wrote:
> 
>>Hi,
>>
>>The attached patch change default permission of files on [v]fatfs.
>>Default RWX have no utilization. This patch remove exec flag.
> 
> Hi !
> 
> This is sometimes very useful to put init scripts on a floppy disk.

Not the common case and you can use different format floppies for this anyway.

 > I'd prefer to keep exec flags. If you don't want files to be executable, you
> still can mount the FS with the 'noexec' option.

Not since: http://www.uwsg.iu.edu/hypermail/linux/kernel/0109.3/0363.html
Ideal would be to have a umask and dmask option (that applied to everything
not just vfat)

See also: http://kt.zork.net/kernel-traffic/kt20020415_162.html#1

Pádraig.


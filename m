Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750855AbWH1OI1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750855AbWH1OI1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 10:08:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750846AbWH1OI1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 10:08:27 -0400
Received: from nz-out-0102.google.com ([64.233.162.204]:45177 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1750837AbWH1OI0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 10:08:26 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:sender;
        b=AyDzOs52El8PyY6hhDaUrrGEZpXGE2Ni98I7nP4hWbCavppbn52lv1YawOmEsSQkQgg6dHOAp1OP6FCSgk79QSRbqyjGDmOz0kGd847O6fzJTcK5ACkP07r+33+8Fp4ZWauKB2bWblx8Pxyd643CxgsAE52gT9l/JHv9JcBXLwo=
Date: Mon, 28 Aug 2006 16:08:00 +0000
From: Frederik Deweerdt <deweerdt@free.fr>
To: Yi Yang <yang.y.yi@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6.18-rc* PATCH RFC]: Correct ambiguous errno of aio
Message-ID: <20060828160800.GA1633@slug>
References: <44F2EF90.9050603@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44F2EF90.9050603@gmail.com>
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 28, 2006 at 09:28:48PM +0800, Yi Yang wrote:
> In the current implementation of AIO, for the operation IOCB_CMD_FDSYNC
> and IOCB_CMD_FSYNC, the returned errno is -EINVAL although the kernel
> does know them, I think the correct errno should be -EOPNOTSUPP which
> means they aren't be implemented or supported.
Hi, 

If I'm not mistaken, returning EINVAL conforms to POSIX, isn't it?
http://www.opengroup.org/onlinepubs/009695399/functions/fsync.html
Regards,
Frederik
 

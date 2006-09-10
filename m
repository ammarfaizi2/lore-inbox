Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750862AbWIJKrF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750862AbWIJKrF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Sep 2006 06:47:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750856AbWIJKrF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Sep 2006 06:47:05 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:42718 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750820AbWIJKrC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Sep 2006 06:47:02 -0400
Subject: Re: [PATCH RFC]: New termios take 2
From: David Woodhouse <dwmw2@infradead.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
In-Reply-To: <1157472883.9018.79.camel@localhost.localdomain>
References: <1157472883.9018.79.camel@localhost.localdomain>
Content-Type: text/plain
Date: Sun, 10 Sep 2006 11:46:20 +0100
Message-Id: <1157885180.2977.133.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-09-05 at 17:14 +0100, Alan Cox wrote:
> +
> +#define TCGETS2                _IOR('T',0x2A, struct termios)
> +#define TCSETS2                _IOW('T',0x2B, struct termios)
> +#define TCSETSW2       _IOW('T',0x2C, struct termios)
> +#define TCSETSF2       _IOW('T',0x2D, struct termios)

So existing code compiled against this will be using the new 'struct
termios' but the old TCGETS. Should we rename the existing ioctl to 
TCGETS_OLD, and have TCGETS be the new one?

I suppose to a large extent it doesn't really matter as long as existing
C libraries happen to get it right -- and since the new structure only
has the new field added, the discrepancy shouldn't matter _too_ much.
But still...

-- 
dwmw2


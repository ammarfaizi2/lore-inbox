Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161125AbWJRPIU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161125AbWJRPIU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 11:08:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161136AbWJRPIU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 11:08:20 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:42372 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1161125AbWJRPIT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 11:08:19 -0400
Subject: Re: [PATCH] OOM killer meets userspace headers
From: David Woodhouse <dwmw2@infradead.org>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20061018145305.GA5345@martell.zuzino.mipt.ru>
References: <20061018145305.GA5345@martell.zuzino.mipt.ru>
Content-Type: text/plain
Date: Wed, 18 Oct 2006 16:08:16 +0100
Message-Id: <1161184096.3376.361.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0 (2.8.0-7.fc6.dwmw2.2) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-10-18 at 18:53 +0400, Alexey Dobriyan wrote:
> Despite mm.h is not being exported header, it does contain one thing
> which is part of userspace ABI -- value disabling OOM killer. So,
> a) export mm.h to userspace

You seem to be adding it _both_ to $(header-y) which makes it get
exported without using unifdef, and to $(unifdef-y) which makes it get
exported _with_ unifdef. Choose one or the other.

Other than that, it looks Ok.

-- 
dwmw2


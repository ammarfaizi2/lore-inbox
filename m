Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030201AbWGYWqw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030201AbWGYWqw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 18:46:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030206AbWGYWqw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 18:46:52 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:62694 "EHLO
	out.lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1030201AbWGYWqv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 18:46:51 -0400
Subject: Re: [PATCH 2/4] [PATCH] gxfb: Fixups for the AMD Geode GX
	framebuffer driver
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jordan Crouse <jordan.crouse@amd.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org,
       linux-fbdev-devel@lists.sourceforge.net, blizzard@redhat.com,
       dwmw2@redhat.com
In-Reply-To: <20060724165602.18822.56823.stgit@cosmic.amd.com>
References: <20060724165454.18822.30310.stgit@cosmic.amd.com>
	 <20060724165602.18822.56823.stgit@cosmic.amd.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 26 Jul 2006 00:48:10 +0100
Message-Id: <1153871290.7559.21.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2006-07-24 at 10:56 -0600, Jordan Crouse wrote:

> +#ifdef CONFIG_FB_GEODE_GX_SET_FBSIZE
> +unsigned int gx_frame_buffer_size(void) {
> +	return CONFIG_FB_GEODE_GX_FBSIZE;
> +}
> +#else
>  unsigned int gx_frame_buffer_size(void)
>  {
>  	unsigned int val;
> @@ -35,6 +40,7 @@ unsigned int gx_frame_buffer_size(void)
>  	val = (unsigned int)(inw(0xAC1E)) & 0xFFl;
>  	return (val << 19);
>  }
> +#endif

GAK, please fix your firmware to follow your own docs 8). I mean while
VGA emulation is hard honouring the frame buffer size query is trivial
to stick in the GPL'd VSA firmware and belongs there.




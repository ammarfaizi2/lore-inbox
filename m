Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966103AbWKOL5T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966103AbWKOL5T (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 06:57:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966515AbWKOL5T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 06:57:19 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:3994 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S966103AbWKOL5S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 06:57:18 -0500
Date: Wed, 15 Nov 2006 11:57:16 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Alexey Dobriyan <adobriyan@openvz.org>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, devel@openvz.org
Subject: Re: [PATCH] Don't give bad kprobes example aka ") < 0))" typo
Message-ID: <20061115115716.GA923@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Alexey Dobriyan <adobriyan@openvz.org>, akpm@osdl.org,
	linux-kernel@vger.kernel.org, devel@openvz.org
References: <20061115155619.GC9011@localhost.sw.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061115155619.GC9011@localhost.sw.ru>
User-Agent: Mutt/1.4.2.2i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 15, 2006 at 06:56:19PM +0300, Alexey Dobriyan wrote:
> Signed-off-by: Alexey Dobriyan <adobriyan@openvz.org>
> ---
> 
>  Documentation/kprobes.txt |    5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> --- a/Documentation/kprobes.txt
> +++ b/Documentation/kprobes.txt
> @@ -442,9 +442,10 @@ static int __init kprobe_init(void)
>  	kp.fault_handler = handler_fault;
>  	kp.symbol_name = "do_fork";
>  
> -	if ((ret = register_kprobe(&kp) < 0)) {
> +	ret = register_kprobe(&kp);
> +	if (ret < 0) {
>  		printk("register_kprobe failed, returned %d\n", ret);
> -		return -1;
> +		return ret;

This looks good, thanks.


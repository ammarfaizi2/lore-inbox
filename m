Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751136AbVI1X6S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751136AbVI1X6S (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 19:58:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751256AbVI1X6S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 19:58:18 -0400
Received: from wproxy.gmail.com ([64.233.184.204]:58591 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751136AbVI1X6R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 19:58:17 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=Ya+UYTf/GuAD7UD0rcIjxvwKcmo82NpwEUvQR1PCo6R0nqlsfU0uPFpXyyTb9gtwuSFkl0QfK/UKLJ5RMQDEitmWX9kNDgx7PJ0jsPYHQpN1y06sD0O2YrUreChu+8rvLgwEtsh5tvQTrwALtjChkP7NPi7zSDhMfogMV7FZSuk=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Abhay Salunke <Abhay_Salunke@dell.com>
Subject: Re: [RFC][patch 2.6.14-rc2] dell_rbu: Changing packet update mechanism
Date: Thu, 29 Sep 2005 02:00:36 +0200
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
References: <20050923194009.GA2682@littleblue.us.dell.com>
In-Reply-To: <20050923194009.GA2682@littleblue.us.dell.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509290200.37203.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 23 September 2005 21:40, Abhay Salunke wrote:
> Please ignore earlier patches as there was error submitting it! :-(
> patch below is good...
> 

Ok, I'm being pedantic. So shoot me.
There are a few tiny bits CodingStyle wise that could be better. No big deal,
I'm nitpicking in the extreme here...


[snip]
> -	pr_debug("fill_last_packet: entry \n");

	pr_debug("fill_last_packet: entry\n");


[snip]
> -	pr_debug("fill_last_packet: exit \n");

	pr_debug("fill_last_packet: exit\n");


[snip]
>  	pr_debug("create_packet: exit \n");

	pr_debug("create_packet: exit\n");


[snip]
> +	temp = (u8 *) data;

	temp = (u8 *)data;


[snip]
> +do_packet_read(char *data, struct list_head *ptemp_list,
>  	int length, int bytes_read, int *list_read_count)

Hmm, I believe the prefered style for functions is to indent parameters that
won't fit on the first line by two tab stops, like this : 

do_packet_read(char *data, struct list_head *ptemp_list,
		int length, int bytes_read, int *list_read_count)

There are several occourences of this.


[snip]
> +packet_read_list(char *data, size_t * pread_length)

packet_read_list(char *data, size_t *pread_length)

[snip]
>   * img_update_free: Frees the buffer allocated for storing BIOS image
>   * Always called with lock held and returned with lock held

 * Always called with lock held and returned with lock held.


[snip]
> +	.attr = {.name = "data",.owner = THIS_MODULE,.mode = 0444},

	.attr = {.name = "data", .owner = THIS_MODULE, .mode = 0444},


[snip]
> +	.attr = {.name = "image_type",.owner = THIS_MODULE,.mode = 0644},

	.attr = {.name = "image_type", .owner = THIS_MODULE, .mode = 0644},


[snip]
> +	.attr = {.name = "packet_size",.owner = THIS_MODULE,.mode = 0644},

	.attr = {.name = "packet_size", .owner = THIS_MODULE, .mode = 0644},



-- 
Jesper Juhl <jesper.juhl@gmail.com>



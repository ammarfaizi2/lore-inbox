Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262133AbUKVPlH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262133AbUKVPlH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 10:41:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261451AbUKVPiZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 10:38:25 -0500
Received: from [213.146.154.40] ([213.146.154.40]:1455 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262126AbUKVPbt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 10:31:49 -0500
Date: Mon, 22 Nov 2004 15:31:44 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Roland Dreier <roland@topspin.com>
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org,
       netdev@oss.sgi.com
Subject: Re: [PATCH][RFC/v1][11/12] Add InfiniBand Documentation files
Message-ID: <20041122153144.GA4821@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Roland Dreier <roland@topspin.com>, linux-kernel@vger.kernel.org,
	openib-general@openib.org, netdev@oss.sgi.com
References: <20041122714.taTI3zcdWo5JfuMd@topspin.com> <20041122714.AyIOvRY195EGFTaO@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041122714.AyIOvRY195EGFTaO@topspin.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +  When the IPoIB driver is loaded, it creates one interface for each
> +  port using the P_Key at index 0.  To create an interface with a
> +  different P_Key, write the desired P_Key into the main interface's
> +  /sys/class/net/<intf name>/create_child file.  For example:
> +
> +    echo 0x8001 > /sys/class/net/ib0/create_child
> +
> +  This will create an interface named ib0.8001 with P_Key 0x8001.  To
> +  remove a subinterface, use the "delete_child" file:
> +
> +    echo 0x8001 > /sys/class/net/ib0/delete_child
> +
> +  The P_Key for any interface is given by the "pkey" file, and the
> +  main interface for a subinterface is in "parent."

Any reason this doesn't use an interface similar to the normal vlan code?

And what is a P_Key?

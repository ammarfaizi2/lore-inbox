Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263330AbSJCPJO>; Thu, 3 Oct 2002 11:09:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263335AbSJCPJN>; Thu, 3 Oct 2002 11:09:13 -0400
Received: from phoenix.infradead.org ([195.224.96.167]:46604 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S263330AbSJCPJH>; Thu, 3 Oct 2002 11:09:07 -0400
Date: Thu, 3 Oct 2002 16:14:05 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Michael Clark <michael@metaparadigm.com>
Cc: Christoph Hellwig <hch@infradead.org>, Kevin Corry <corryk@us.ibm.com>,
       torvalds@transmeta.com, linux-kernel@vger.kernel.org,
       evms-devel@lists.sourceforge.net
Subject: Re: [Evms-devel] Re: [PATCH] EVMS core 2/4: evms.h
Message-ID: <20021003161405.A20832@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Michael Clark <michael@metaparadigm.com>,
	Kevin Corry <corryk@us.ibm.com>, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org, evms-devel@lists.sourceforge.net
References: <02100307363402.05904@boiler> <20021003155023.C17513@infradead.org> <3D9C5DD6.40103@metaparadigm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3D9C5DD6.40103@metaparadigm.com>; from michael@metaparadigm.com on Thu, Oct 03, 2002 at 11:10:14PM +0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 03, 2002 at 11:10:14PM +0800, Michael Clark wrote:
> 
> >>+#define DEV_PATH			"/dev"
> >>+#define EVMS_DIR_NAME			"evms"
> >>+#define EVMS_DEV_NAME			"block_device"
> >>+#define EVMS_DEV_NODE_PATH		DEV_PATH "/" EVMS_DIR_NAME "/"
> >>+#define EVMS_DEVICE_NAME		DEV_PATH "/" EVMS_DIR_NAME "/" EVMS_DEV_NAME
> > 
> > 
> > The kernel doesn't know about device names at all.
> 
> It does for specifying root devices and for devfs.A

root device should be in do_mount.c and not in obscure headers.
devfs doesn'T need hardcoded "/dev" prefixes, and it's better to not
add defines for the strings in devfs so that crap doesn't get spread
over the code but is localized to the existing devfs damage

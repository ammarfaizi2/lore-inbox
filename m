Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423865AbWKIEi6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423865AbWKIEi6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 23:38:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424047AbWKIEi5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 23:38:57 -0500
Received: from nf-out-0910.google.com ([64.233.182.189]:1676 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1423865AbWKIEi4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 23:38:56 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=f8hvgSnGn75WY+/LjV4j/60f7XX51DEc71/gH29HaQHFasjEzFc7JJD9jxPn5oYaT/nifu4ioQ07m9FyNN5opDLA7CTHrCt7wcG5jwxaVJuJ4oJ4ImjorKq6+0BdGrjRIbBkxt2jkulvBSTIq9WAQHGtVqXPxThg7dmY89c7hOg=
Message-ID: <4552B0D6.5040100@gmail.com>
Date: Thu, 09 Nov 2006 13:38:46 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Icedove 1.5.0.7 (X11/20061014)
MIME-Version: 1.0
To: Stephen.Clark@seclark.us
CC: Stephen Hemminger <shemminger@osdl.org>,
       Francois Romieu <romieu@fr.zoreil.com>,
       Jiri Slaby <jirislaby@gmail.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Dave Jones <davej@redhat.com>, netdev@vger.kernel.org
Subject: Re: New laptop - problems with linux
References: <4551EC86.5010600@seclark.us>	<4551F3A6.8040807@gmail.com>	<4551F5B7.1050709@seclark.us>	<20061108182658.GA21154@electric-eye.fr.zoreil.com>	<45523289.2010002@seclark.us> <20061108122649.2f79ec1f@freekitty> <45523F3F.8010806@seclark.us>
In-Reply-To: <45523F3F.8010806@seclark.us>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Clark wrote:
> Thanks I have that working - I am now struggling with the disk being
> slower than molasses ( high priority, 1.xx mb/sec  )

Add 'combined_mode=libata' to kernel parameter and see what happens. 
This should make libata take care of all ATA ports and your harddisks 
will appear as /dev/sda and sdb, your cdrom /dev/sr0.  So, you might 
need to adjust root= parameter too.

-- 
tejun

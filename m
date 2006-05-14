Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751386AbWENXTV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751386AbWENXTV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 May 2006 19:19:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751396AbWENXTV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 May 2006 19:19:21 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:5675 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751386AbWENXTV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 May 2006 19:19:21 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=uZlU3Olg04HFF8EJvHuuLRkfF0xyWMmvw4y/I0H3isaNviUTYVhvch5VX+q2hA3nx3HJnX39wGm3cB9OGisjc358AgdpkBNnk+UPZDtasXLamAcWk7ODPZGIMQZrOyLYHpzbQNUSHwUz2tW7D5QbI/wOcYgzefP27ILFaavhjcc=
Message-ID: <70066d530605141619p40ca79c0uaa047918c11c37bb@mail.gmail.com>
Date: Mon, 15 May 2006 07:19:19 +0800
From: "Jaya Kumar" <jayakumar.video@gmail.com>
To: "Oliver Neukum" <oliver@neukum.org>
Subject: Re: [PATCH/RFC 2.6.16.5 1/1] usb/media/quickcam_messenger driver
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
In-Reply-To: <200605141824.28161.oliver@neukum.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200605141411.k4EEBaO4022817@localhost.localdomain>
	 <200605141824.28161.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/15/06, Oliver Neukum <oliver@neukum.org> wrote:
> Building this data structure on the stack is a shooting offense.

I completely agree with you (except for the shooting part :-). I'll
make the corrections. In my defense, I copied that from the konicawc
code.

drivers/usb/media/konicawc.c

921 static int __init konicawc_init(void)
922 {
923         struct usbvideo_cb cbTbl;
924         info(DRIVER_DESC " " DRIVER_VERSION);
925         memset(&cbTbl, 0, sizeof(cbTbl));
926         cbTbl.probe = konicawc_probe;
927         cbTbl.setupOnOpen = konicawc_setup_on_open;
928         cbTbl.processData = konicawc_process_isoc;
929         cbTbl.getFPS = konicawc_calculate_fps;
930         cbTbl.setVideoMode = konicawc_set_video_mode;
931         cbTbl.startDataPump = konicawc_start_data;

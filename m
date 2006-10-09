Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932991AbWJIRVb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932991AbWJIRVb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 13:21:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932992AbWJIRVb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 13:21:31 -0400
Received: from mtagate5.de.ibm.com ([195.212.29.154]:10116 "EHLO
	mtagate5.de.ibm.com") by vger.kernel.org with ESMTP id S932991AbWJIRVa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 13:21:30 -0400
Date: Mon, 9 Oct 2006 19:22:01 +0200
From: Cornelia Huck <cornelia.huck@de.ibm.com>
To: Luca Tettamanti <kronos.it@gmail.com>
Cc: Greg KH <gregkh@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.19-git] Fix error handling in create_files()
Message-ID: <20061009192201.140eae35@gondolin.boeblingen.de.ibm.com>
In-Reply-To: <20061009170357.GA16816@dreamland.darkstar.lan>
References: <20061009164017.GA13698@dreamland.darkstar.lan>
	<20061009164820.GA22630@suse.de>
	<20061009170357.GA16816@dreamland.darkstar.lan>
X-Mailer: Sylpheed-Claws 2.5.0-rc3 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Oct 2006 19:03:57 +0200,
Luca Tettamanti <kronos.it@gmail.com> wrote:

> While we are at it: is it safe to always call sysfs_remove_group even if
> the preceding sysfs_create_group failed?

No, it will oops in remove_dir(). (See also the recent discussion in
"drivers/base: error handling fixes" - drivers/base/topology.c has
problems in that area as well...)

-- 
Cornelia Huck
Linux for zSeries Developer
Tel.: +49-7031-16-4837, Mail: cornelia.huck@de.ibm.com

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263913AbTICRiH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 13:38:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264005AbTICRiE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 13:38:04 -0400
Received: from fw.osdl.org ([65.172.181.6]:58809 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263913AbTICRhb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 13:37:31 -0400
Date: Wed, 3 Sep 2003 10:20:42 -0700
From: Andrew Morton <akpm@osdl.org>
To: Dave Olien <dmo@osdl.org>
Cc: linux-kernel@vger.kernel.org, maryedie@osdl.org
Subject: Re: FYI: dbt testing on 2.6.0-test4-mm4 fails
Message-Id: <20030903102042.52020776.akpm@osdl.org>
In-Reply-To: <20030903170716.GA23487@osdl.org>
References: <20030903170716.GA23487@osdl.org>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Olien <dmo@osdl.org> wrote:
>
> I'm just mailing you this to keep you informed, Daniel McNeil and
> I are investigating a failure of the dbt database workload test on
> 2.6.0-test4-mm4.

hmm, the direct-io code hasn't changed significantly since February(!).

Which filesystem are you using?

One possibility is that some lower-level error occured in the filesystem or
the device driver but the error code was not correctly propagated back. 
Could you sprinkle error-path printk's in the direct-io code?



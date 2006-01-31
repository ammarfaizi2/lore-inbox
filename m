Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751450AbWAaUM1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751450AbWAaUM1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 15:12:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751451AbWAaUM1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 15:12:27 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:34450 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751450AbWAaUM0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 15:12:26 -0500
Subject: Re: [PATCH 09/11] kbuild: drop vmlinux dependency from "make
	install"
From: Dave Hansen <haveblue@us.ibm.com>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <11368427243850@foobar.com>
References: <11368427243850@foobar.com>
Content-Type: text/plain
Date: Tue, 31 Jan 2006 12:11:59 -0800
Message-Id: <1138738320.6424.37.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-01-09 at 22:38 +0100, Sam Ravnborg wrote:
> This removes the dependency from vmlinux to install, thus avoiding the
> current situation where "make install" has a nasty tendency to leave
> root-turds in the working directory.

One minor issue I've noticed with this is that I have script that do:

	make -j8 vmlinux install

Without the dependency, I think the install is done in parallel, and
doesn't get the result of that build.  Is there a way I can accomplish
the same thing with one make command with the new dependency?

-- Dave


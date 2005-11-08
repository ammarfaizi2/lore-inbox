Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965110AbVKHHuF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965110AbVKHHuF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 02:50:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965127AbVKHHuF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 02:50:05 -0500
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:35533
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S965110AbVKHHuE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 02:50:04 -0500
Message-Id: <437066EC.76F0.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0 
Date: Tue, 08 Nov 2005 08:50:52 +0100
From: "Jan Beulich" <JBeulich@novell.com>
To: "Sam Ravnborg" <sam@ravnborg.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] slightly enhance cross builds
References: <436F5D96.76F0.0078.0@novell.com> <20051107230426.GD10492@mars.ravnborg.org>
In-Reply-To: <20051107230426.GD10492@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>> Sam Ravnborg <sam@ravnborg.org> 08.11.05 00:04:26 >>>
>On Mon, Nov 07, 2005 at 01:58:46PM +0100, Jan Beulich wrote:
>> This adds functionality to default CROSS_COMPILE to a sensible
value
>> when cross-building (so one doesn't always have to specify this on
the
>> make command line), as well as storing ARCH and SUBARCH in the
>> Makefile
>> generated when building outside of the source directory (so that
>> subsequent make invocations don't have to always repeat these).
>
>This patch introduce different behaviour with and without make O=
>This will result on confusion and is bad.

Though I admit that I never build inside the source tree, I can't see
what you apparently do. Where/how would the behavior differ? If you just
mean the fact that in-source-tree builds will need to continue to
specify ARCH/SUBARCH on the make command line, then of course yes, this
is going to be different. But building in the source tree is a bad idea
in general in my opinion, and hence I would view this as the price you
pay. Of course this information could be stored in a hidden file in the
output tree (rather than in mkmakefile itself) if that's more
desirable...

>The right approach is to come up with a patch that works in both
cases.

Jan

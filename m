Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992624AbWJTQx5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992624AbWJTQx5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 12:53:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992676AbWJTQx5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 12:53:57 -0400
Received: from xdsl-664.zgora.dialog.net.pl ([81.168.226.152]:20751 "EHLO
	tuxland.pl") by vger.kernel.org with ESMTP id S2992624AbWJTQx4 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 12:53:56 -0400
From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
Organization: tuxland
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.19-rc2-mm2
Date: Fri, 20 Oct 2006 18:54:43 +0200
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
References: <20061020015641.b4ed72e5.akpm@osdl.org> <200610201339.49190.m.kozlowski@tuxland.pl> <20061020091901.71a473e9.akpm@osdl.org>
In-Reply-To: <20061020091901.71a473e9.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200610201854.43893.m.kozlowski@tuxland.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, 

> Don't know.   Nothing has changed in the git-pcmcia tree since July.
>
> Are you able to bisect it, as per
> http://www.zip.com.au/~akpm/linux/patches/stuff/bisecting-mm-trees.txt ?
>
> > When running without debug options enabled also these were seen amongst
> > dmesg lines:
> >
> > [drm:radeon_cp_init] *ERROR* radeon_cp_init called without lock held
> > [drm:drm_unlock] *ERROR* Process 5131 using kernel context 0
>
> <googles>
>
> This? http://lkml.org/lkml/2005/9/10/78

I think I found the culprit. It's CONFIG_PCI_MULTITHREAD_PROBE option. It is 
actually marked as EXPERIMENTAL and there is even a proper warning included 
on the help page. Disabling it makes the kernel behave the right way. So 
should what I reported be considered a real error or not? Then the next 
question is should I report errors caused by options marked as EXPERIMENTAL 
or just leave it the way it is until the option is not EXPERIMENTAL anymore?

>> This time it _is_ -mm ;-)
>> 
>Well... that's what it's for ;)  Thanks for testing.

No problem. Thanks for Linux.

Regards,

	Mariusz Kozlowski

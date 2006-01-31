Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030282AbWAaIEJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030282AbWAaIEJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 03:04:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965056AbWAaIEJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 03:04:09 -0500
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:9661
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S965055AbWAaIEI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 03:04:08 -0500
Message-Id: <43DF19EC020000780000F8BE@emea1-mh.id2.novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0 
Date: Tue, 31 Jan 2006 09:03:55 +0100
From: "Jan Beulich" <jbeulich@novell.com>
To: <sam@ravnborg.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] consolidate command line escaping
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> -cmd = @$(if $($(quiet)cmd_$(1)),\
>> -      echo '  $(call escsq,$($(quiet)cmd_$(1)))' &&) $(cmd_$(1))
>> +cmd = @$(echo-cmd) $(cmd_$(1))
>Here you replace 
>	echo 'xxx' && cmd
>with
>	echo 'xxx'; cmd
>
>Since we assume echo will always succeed I see no difference in
>behaviour, but I recall the '&&' was there for some specific reason.
>Just wondering why it is so - I see no problems with it.

Since I didn't see a difference in behavior, and it permitted more re-use of existing constructs, I thought it'd be
reasonable to be replaced; I didn't know of anything that would require the &&.

Jan


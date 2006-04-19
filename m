Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751126AbWDSSFH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751126AbWDSSFH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 14:05:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751130AbWDSSFH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 14:05:07 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:45804 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751126AbWDSSFF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 14:05:05 -0400
Subject: Re: [RFC][PATCH 3/11] security: AppArmor - LSM interface
From: Arjan van de Ven <arjan@infradead.org>
To: Tony Jones <tonyj@suse.de>
Cc: linux-kernel@vger.kernel.org, chrisw@sous-sol.org,
       linux-security-module@vger.kernel.org
In-Reply-To: <20060419174929.29149.20126.sendpatchset@ermintrude.int.wirex.com>
References: <20060419174905.29149.67649.sendpatchset@ermintrude.int.wirex.com>
	 <20060419174929.29149.20126.sendpatchset@ermintrude.int.wirex.com>
Content-Type: text/plain
Date: Wed, 19 Apr 2006 20:05:02 +0200
Message-Id: <1145469902.3085.77.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> +#ifndef MODULE
> +static int __init aa_getopt_complain(char *str)
> +{
> +	get_option(&str, &apparmor_complain);
> +	return 1;
> +}
> +__setup("apparmor_complain=", aa_getopt_complain);

this is just bogus; in 2.6 at least. No need for ifdef; module
parameters can be set on the kernel commandline for the non-module case




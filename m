Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261332AbSJPT23>; Wed, 16 Oct 2002 15:28:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261340AbSJPT23>; Wed, 16 Oct 2002 15:28:29 -0400
Received: from DSL022.LABridge.com ([206.117.136.22]:58379 "EHLO Perches.com")
	by vger.kernel.org with ESMTP id <S261332AbSJPT22>;
	Wed, 16 Oct 2002 15:28:28 -0400
Subject: Re: [RFC] change format of LSM hooks
From: joe perches <joe@perches.com>
To: greg@kroah.com, linux-kernel@vger.kernel.org
In-Reply-To: <20021016185927.GA25475@kroah.com>
References: <20021015194545.GC15864@kroah.com>
	<20021015.124502.130514745.davem@redhat.com>
	<20021015201209.GE15864@kroah.com>
	<20021015.131037.96602290.davem@redhat.com>
	<20021015202828.GG15864@kroah.com> <20021016000706.GI16966@kroah.com>
	<20021016081539.GF20421@kroah.com>  <20021016185927.GA25475@kroah.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8-3mdk 
Date: 16 Oct 2002 12:33:50 -0400
Message-Id: <1034786033.9520.8.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-10-16 at 14:59, Greg KH wrote:

I think something like:

	#define check_security(type,args...) security_##type(##args)

would be cleaner and would prefer not collapsing the

	ret = check_security()
	if (ret)

function use


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932324AbWDUOyz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932324AbWDUOyz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 10:54:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932333AbWDUOyz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 10:54:55 -0400
Received: from web52913.mail.yahoo.com ([206.190.49.23]:17807 "HELO
	web52913.mail.yahoo.com") by vger.kernel.org with SMTP
	id S932324AbWDUOyy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 10:54:54 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=YPRvLGiCCRwCFfQPssmlOsT54GajwxjMNkLaAC2LqezL/rbF3sb0G94G4szMJJMMfPdz6I2/A8MVDGE5ZoWF8gjAWAPjgeHVUn7LjIrGGw/5B1QJB5GIMPSxdGYjBVX2v2pTfPxDI8b/868KfCruz3d50oBQwiox6IszHJPvr6k=  ;
Message-ID: <20060421145453.18587.qmail@web52913.mail.yahoo.com>
Date: Fri, 21 Apr 2006 15:54:53 +0100 (BST)
From: Chris Rankin <rankincj@yahoo.com>
Subject: Re: [patch 05/22] : Fix hotplug race during device registration
To: "Alexander E. Patrakov" <patrakov@ums.usu.ru>
Cc: greg@kroah.com, linux-kernel@vger.kernel.org
In-Reply-To: <4448DBC6.2090700@ums.usu.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- "Alexander E. Patrakov" <patrakov@ums.usu.ru> wrote:
> This could be fixed up by saving the old value and restoring it in the "if 
> (err)" statement, but I guess this has to be fixed in the mainline before 
> allowing the modified "if (err)" into -stable.

I'm not going to claim to know how this state machine works, but would restoring the state to the
original value prompt the kernel to try and reregister the device in an endless loop? I was
wondering if maybe it should be set to some "Failed" state instead.

Cheers,
Chris


		
___________________________________________________________ 
To help you stay safe and secure online, we've developed the all new Yahoo! Security Centre. http://uk.security.yahoo.com

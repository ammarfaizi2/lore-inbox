Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031882AbWLGJ16@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031882AbWLGJ16 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 04:27:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968828AbWLGJ16
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 04:27:58 -0500
Received: from bill.weihenstephan.org ([82.135.35.21]:48725 "EHLO
	bill.weihenstephan.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S968827AbWLGJ15 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 04:27:57 -0500
From: Juergen Beisert <juergen127@kreuzholzen.de>
Organization: Privat
To: linux-kernel@vger.kernel.org
Subject: Re: The invoking of probe function for platform devices ??
Date: Thu, 7 Dec 2006 10:27:51 +0100
User-Agent: KMail/1.9.4
References: <F6E1228667B6D411BAAA00306E00F2A50AB71042@pdc2.nestec.net>
In-Reply-To: <F6E1228667B6D411BAAA00306E00F2A50AB71042@pdc2.nestec.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612071027.51850.juergen127@kreuzholzen.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 07 December 2006 09:02, ANIL JACOB wrote:
> At what stage of the initiation the probe function is called. I guess when
> compiled as a module, the only entry point of the driver I will be having
> is init function and the exit point is exit function. Then how will it be
> entering into the probe function for platform devices?

When the platform device is known, probe will be called after registering your 
platform driver.
If the platform device is unknown, your probe will never be called.
If the platform device gets registered later, then this is the time when your 
platform driver probe will be called.

Hope it helps
Juergen

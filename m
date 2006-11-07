Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750939AbWKGOnk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750939AbWKGOnk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 09:43:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752906AbWKGOnj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 09:43:39 -0500
Received: from 195-13-16-24.net.novis.pt ([195.23.16.24]:37088 "EHLO
	bipbip.grupopie.com") by vger.kernel.org with ESMTP
	id S1750939AbWKGOni (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 09:43:38 -0500
Message-ID: <45509B97.2080104@grupopie.com>
Date: Tue, 07 Nov 2006 14:43:35 +0000
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Thunderbird 1.5.0.7 (X11/20060909)
MIME-Version: 1.0
To: Rik Bobbaers <Rik.Bobbaers@cc.kuleuven.be>
CC: linux-kernel@vger.kernel.org, linux-mm@vger.kernel.org
Subject: Re: very small code cleanup
References: <4550986C.8020802@cc.kuleuven.be>
In-Reply-To: <4550986C.8020802@cc.kuleuven.be>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik Bobbaers wrote:
> hey all,
> 
> in mm/mlock.c , mm is defined as vma->vm_mm, why not use that one for 
> the decrement of pages?

Because vma can change here:

	if (*prev) {
		vma = *prev;
		goto success;
	}

and then mm won't be the same as vma->vm_mm..

-- 
Paulo Marques - www.grupopie.com

"The face of a child can say it all, especially the
mouth part of the face."

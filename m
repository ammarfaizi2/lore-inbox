Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262165AbVELWzx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262165AbVELWzx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 May 2005 18:55:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262168AbVELWzx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 May 2005 18:55:53 -0400
Received: from mail.kroah.org ([69.55.234.183]:51630 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262165AbVELWzw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 May 2005 18:55:52 -0400
Date: Thu, 12 May 2005 15:55:42 -0700
From: Greg KH <greg@kroah.com>
To: Kylene Hall <kjhall@us.ibm.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tpm: improve output in sysfs files when the TPM fails
Message-ID: <20050512225541.GA29958@kroah.com>
References: <Pine.LNX.4.62.0505121717240.11837@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0505121717240.11837@localhost.localdomain>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 12, 2005 at 05:20:22PM -0500, Kylene Hall wrote:
> When the TPM is in a disabled or deactivated state the sysfs pcrs and 
> pubek files will appear empty.  To remove any confusion this might cause, 
> the files will instead contain the error the TPM returned (also indicative 
> of what state the TPM is in and what actions might be needed to change 
> that state).

No, sysfs files are not error logs.  Please use the standard system wide
error log for this (syslog).

Why not just change the mode of the sysfs file instead, or delete it
entirely in this case?

thanks,

greg k-h

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964904AbWARDz7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964904AbWARDz7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 22:55:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964906AbWARDz7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 22:55:59 -0500
Received: from smtp104.sbc.mail.re2.yahoo.com ([68.142.229.101]:9073 "HELO
	smtp104.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S964903AbWARDz6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 22:55:58 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Kristen Accardi <kristen.c.accardi@intel.com>
Subject: Re: [patch 2/4]  acpiphp: handle dock bridges
Date: Tue, 17 Jan 2006 22:55:52 -0500
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, greg@kroah.com,
       pcihpd-discuss@lists.sourceforge.net, len.brown@intel.com,
       linux-acpi@vger.kernel.org, pavel@ucw.cz
References: <20060116200218.275371000@whizzy> <1137545819.19858.47.camel@whizzy>
In-Reply-To: <1137545819.19858.47.camel@whizzy>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601172255.53650.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 17 January 2006 19:56, Kristen Accardi wrote:

> +
> +	down(&slot->crit_sect);
> +	list_for_each(l, &slot->funcs) {
> +		func = list_entry(l, struct acpiphp_func, sibling);

list_for_each_entry() maybe?

> +static struct acpiphp_func * get_func(struct acpiphp_slot *slot,
> +					struct pci_dev *dev)
> +{
> +	struct list_head *l;
> +	struct acpiphp_func *func;
> +	struct pci_bus *bus = slot->bridge->pci_bus;
> +
> +	list_for_each (l, &slot->funcs) {
> +		func = list_entry(l, struct acpiphp_func, sibling);

And here?

-- 
Dmitry

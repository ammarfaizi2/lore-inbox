Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264937AbUGTAU5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264937AbUGTAU5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jul 2004 20:20:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264991AbUGTAU5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jul 2004 20:20:57 -0400
Received: from web53807.mail.yahoo.com ([206.190.36.202]:21593 "HELO
	web53807.mail.yahoo.com") by vger.kernel.org with SMTP
	id S264937AbUGTAUd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jul 2004 20:20:33 -0400
Message-ID: <20040720002032.64645.qmail@web53807.mail.yahoo.com>
Date: Mon, 19 Jul 2004 17:20:32 -0700 (PDT)
From: Carl Spalletta <cspalletta@yahoo.com>
Subject: [PATCH] remove 68 dead prototypes from include/acpi/acdebug.h
To: lkml <linux-kernel@vger.kernel.org>
Cc: len.brown@intel.com, acpi-devel@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-2119703764-1090282832=:62264"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--0-2119703764-1090282832=:62264
Content-Type: text/plain; charset=us-ascii
Content-Id: 
Content-Disposition: inline

This patch removes 68 prototypes of nonexistent functions.

N.B.
  File to be patched has not been touched in more than a year except for a change
of copyright date.

This patch has also been included as an attachment due to my inability to cut and paste
<tab> chars embedded in file - they are picked up as sequences of spaces. Use attached
version or 'unexpand' the following.

Signed-off-by: Carl Spalletta <cspalletta@yahoo.com>

diff -ru /usr/src/linux-2.6.7-orig/include/acpi/acdebug.h
/usr/src/linux-2.6.7-new/include/acpi/acdebug.h
--- /usr/src/linux-2.6.7-orig/include/acpi/acdebug.h    2004-06-15 22:18:59.000000000 -0700
+++ /usr/src/linux-2.6.7-new/include/acpi/acdebug.h     2004-07-18 20:00:10.000000000 -0700
@@ -92,378 +92,31 @@
        union acpi_parse_object         *op,
        u32                             op_type);

-acpi_status
-acpi_db_start_command (
-       struct acpi_walk_state          *walk_state,
-       union acpi_parse_object         *op);
-
 void
 acpi_db_method_end (
        struct acpi_walk_state          *walk_state);

-
-/*
- * dbcmds - debug commands and output routines
- */
-
-void
-acpi_db_display_table_info (
-       char                            *table_arg);
-
-void
-acpi_db_unload_acpi_table (
-       char                            *table_arg,
-       char                            *instance_arg);
-
-void
-acpi_db_set_method_breakpoint (
-       char                            *location,
-       struct acpi_walk_state          *walk_state,
-       union acpi_parse_object         *op);
-
-void
-acpi_db_set_method_call_breakpoint (
-       union acpi_parse_object         *op);
-
-void
-acpi_db_disassemble_aml (
-       char                            *statements,
-       union acpi_parse_object         *op);
-
-void
-acpi_db_dump_namespace (
-       char                            *start_arg,
-       char                            *depth_arg);
-
-void
-acpi_db_dump_namespace_by_owner (
-       char                            *owner_arg,
-       char                            *depth_arg);
-
-void
-acpi_db_send_notify (
-       char                            *name,
-       u32                             value);
-
-void
-acpi_db_set_method_data (
-       char                            *type_arg,
-       char                            *index_arg,
-       char                            *value_arg);
-
-acpi_status
-acpi_db_display_objects (
-       char                            *obj_type_arg,
-       char                            *display_count_arg);
-
-acpi_status
-acpi_db_find_name_in_namespace (
-       char                            *name_arg);
-
-void
-acpi_db_set_scope (
-       char                            *name);
-
-void
-acpi_db_find_references (
-       char                            *object_arg);
-
-void
-acpi_db_display_locks (void);
-
-
-void
-acpi_db_display_resources (
-       char                            *object_arg);
-
-void
-acpi_db_display_gpes (void);
-
-void
-acpi_db_check_integrity (
-       void);
-
-acpi_status
-acpi_db_integrity_walk (
-       acpi_handle                     obj_handle,
-       u32                             nesting_level,
-       void                            *context,
-       void                            **return_value);
-
-acpi_status
-acpi_db_walk_and_match_name (
-       acpi_handle                     obj_handle,
-       u32                             nesting_level,
-       void                            *context,
-       void                            **return_value);
-
-acpi_status
-acpi_db_walk_for_references (
-       acpi_handle                     obj_handle,
-       u32                             nesting_level,
-       void                            *context,
-       void                            **return_value);
-
-acpi_status
-acpi_db_walk_for_specific_objects (
-       acpi_handle                     obj_handle,
-       u32                             nesting_level,
-       void                            *context,
-       void                            **return_value);
-
-void
-acpi_db_generate_gpe (
-       char                            *gpe_arg,
-       char                            *block_arg);
-
 /*
  * dbdisply - debug display commands
  */

 void
-acpi_db_display_method_info (
-       union acpi_parse_object         *op);
-
-void
-acpi_db_decode_and_display_object (
-       char                            *target,
-       char                            *output_type);
-
-void
 acpi_db_display_result_object (
        union acpi_operand_object       *obj_desc,
        struct acpi_walk_state          *walk_state);

-acpi_status
-acpi_db_display_all_methods (
-       char                            *display_count_arg);
-
-void
-acpi_db_display_arguments (
-       void);
-
-void
-acpi_db_display_locals (
-       void);
-
-void
-acpi_db_display_results (
-       void);
-
-void
-acpi_db_display_calling_tree (
-       void);
-
-void
-acpi_db_display_object_type (
-       char                            *object_arg);
-
 void
 acpi_db_display_argument_object (
        union acpi_operand_object       *obj_desc,
        struct acpi_walk_state          *walk_state);

-void
-acpi_db_dump_parser_descriptor (
-       union acpi_parse_object         *op);
-
-void *
-acpi_db_get_pointer (
-       void                            *target);
-
-
-/*
- * dbexec - debugger control method execution
- */
-
-void
-acpi_db_execute (
-       char                            *name,
-       char                            **args,
-       u32                             flags);
-
-void
-acpi_db_create_execution_threads (
-       char                            *num_threads_arg,
-       char                            *num_loops_arg,
-       char                            *method_name_arg);
-
-acpi_status
-acpi_db_execute_method (
-       struct acpi_db_method_info      *info,
-       struct acpi_buffer              *return_obj);
-
-void
-acpi_db_execute_setup (
-       struct acpi_db_method_info      *info);
-
-u32
-acpi_db_get_outstanding_allocations (
-       void);
-
-void ACPI_SYSTEM_XFACE
-acpi_db_method_thread (
-       void                            *context);
-
-acpi_status
-acpi_db_execution_walk (
-       acpi_handle                     obj_handle,
-       u32                             nesting_level,
-       void                            *context,
-       void                            **return_value);
-
-
-/*
- * dbfileio - Debugger file I/O commands
- */
-
-acpi_object_type
-acpi_db_match_argument (
-       char                            *user_argument,
-       struct argument_info            *arguments);
-
-acpi_status
-ae_local_load_table (
-       struct acpi_table_header        *table_ptr);
-
-void
-acpi_db_close_debug_file (
-       void);
-
-void
-acpi_db_open_debug_file (
-       char                            *name);
-
-acpi_status
-acpi_db_load_acpi_table (
-       char                            *filename);
-
-acpi_status
-acpi_db_get_table_from_file (
-       char                            *filename,
-       struct acpi_table_header        **table);
-
-acpi_status
-acpi_db_read_table_from_file (
-       char                            *filename,
-       struct acpi_table_header        **table);
-
-/*
- * dbhistry - debugger HISTORY command
- */
-
-void
-acpi_db_add_to_history (
-       char                            *command_line);
-
-void
-acpi_db_display_history (void);
-
-char *
-acpi_db_get_from_history (
-       char                            *command_num_arg);
-
-
 /*
  * dbinput - user front-end to the AML debugger
  */

 acpi_status
-acpi_db_command_dispatch (
-       char                            *input_buffer,
-       struct acpi_walk_state          *walk_state,
-       union acpi_parse_object         *op);
-
-void ACPI_SYSTEM_XFACE
-acpi_db_execute_thread (
-       void                            *context);
-
-acpi_status
 acpi_db_user_commands (
        char                            prompt,
        union acpi_parse_object         *op);

-void
-acpi_db_display_help (
-       char                            *help_type);
-
-char *
-acpi_db_get_next_token (
-       char                            *string,
-       char                            **next);
-
-u32
-acpi_db_get_line (
-       char                            *input_buffer);
-
-u32
-acpi_db_match_command (
-       char                            *user_command);
-
-void
-acpi_db_single_thread (
-       void);
-
-
-/*
- * dbstats - Generation and display of ACPI table statistics
- */
-
-void
-acpi_db_generate_statistics (
-       union acpi_parse_object         *root,
-       u8                              is_method);
-
-
-acpi_status
-acpi_db_display_statistics (
-       char                            *type_arg);
-
-acpi_status
-acpi_db_classify_one_object (
-       acpi_handle                     obj_handle,
-       u32                             nesting_level,
-       void                            *context,
-       void                            **return_value);
-
-void
-acpi_db_count_namespace_objects (
-       void);
-
-void
-acpi_db_enumerate_object (
-       union acpi_operand_object       *obj_desc);
-
-
-/*
- * dbutils - AML debugger utilities
- */
-
-void
-acpi_db_set_output_destination (
-       u32                             where);
-
-void
-acpi_db_dump_buffer (
-       u32                             address);
-
-void
-acpi_db_dump_object (
-       union acpi_object               *obj_desc,
-       u32                             level);
-
-void
-acpi_db_prep_namestring (
-       char                            *name);
-
-
-acpi_status
-acpi_db_second_pass_parse (
-       union acpi_parse_object         *root);
-
-struct acpi_namespace_node *
-acpi_db_local_ns_lookup (
-       char                            *name);
-
-
 #endif  /* __ACDEBUG_H__ */
--0-2119703764-1090282832=:62264
Content-Type: application/octet-stream; name=acdebug-patch
Content-Transfer-Encoding: base64
Content-Description: acdebug-patch
Content-Disposition: attachment; filename=acdebug-patch

VGhpcyBwYXRjaCByZW1vdmVzIDY4IHByb3RvdHlwZXMgb2Ygbm9uZXhpc3Rl
bnQgZnVuY3Rpb25zLgoKTi5CLgpQYXRjaGVkIGZpbGUgaGFzIG5vdCBiZWVu
IHRvdWNoZWQgaW4gbW9yZSB0aGFuIGEgeWVhciBleGNlcHQgZm9yIGEgY2hh
bmdlIG9mIGNvcHlyaWdodCBkYXRlLgoKVGhlIHBhdGNoIGhhcyBhbHNvIGJl
ZW4gaW5jbHVkZWQgYXMgYW4gYXR0YWNobWVudCBkdWUgdG8gbXkgaW5hYmls
aXR5IHRvIGN1dCBhbmQgcGFzdGUKPHRhYj4gY2hhcnMgZW1iZWRkZWQgaW4g
ZmlsZSAtIHRoZXkgYXJlIHBpY2tlZCB1cCBhcyBzZXF1ZW5jZXMgb2Ygc3Bh
Y2VzLiBVc2UgdGhhdCBvcgondW5leHBhbmQnIHRoZSB2ZXJzaW9uIGJlbG93
LgoKU2lnbmVkLW9mZi1ieTogQ2FybCBTcGFsbGV0dGEgPGNzcGFsbGV0dGFA
eWFob28uY29tPgoKZGlmZiAtcnUgL3Vzci9zcmMvbGludXgtMi42Ljctb3Jp
Zy9pbmNsdWRlL2FjcGkvYWNkZWJ1Zy5oIC91c3Ivc3JjL2xpbnV4LTIuNi43
LW5ldy9pbmNsdWRlL2FjcGkvYWNkZWJ1Zy5oCi0tLSAvdXNyL3NyYy9saW51
eC0yLjYuNy1vcmlnL2luY2x1ZGUvYWNwaS9hY2RlYnVnLmggICAgMjAwNC0w
Ni0xNSAyMjoxODo1OS4wMDAwMDAwMDAgLTA3MDAKKysrIC91c3Ivc3JjL2xp
bnV4LTIuNi43LW5ldy9pbmNsdWRlL2FjcGkvYWNkZWJ1Zy5oICAgICAyMDA0
LTA3LTE4IDIwOjAwOjEwLjAwMDAwMDAwMCAtMDcwMApAQCAtOTIsMzc4ICs5
MiwzMSBAQAogICAgICAgIHVuaW9uIGFjcGlfcGFyc2Vfb2JqZWN0ICAgICAg
ICAgKm9wLAogICAgICAgIHUzMiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgb3BfdHlwZSk7CgotYWNwaV9zdGF0dXMKLWFjcGlfZGJfc3RhcnRfY29t
bWFuZCAoCi0gICAgICAgc3RydWN0IGFjcGlfd2Fsa19zdGF0ZSAgICAgICAg
ICAqd2Fsa19zdGF0ZSwKLSAgICAgICB1bmlvbiBhY3BpX3BhcnNlX29iamVj
dCAgICAgICAgICpvcCk7Ci0KIHZvaWQKIGFjcGlfZGJfbWV0aG9kX2VuZCAo
CiAgICAgICAgc3RydWN0IGFjcGlfd2Fsa19zdGF0ZSAgICAgICAgICAqd2Fs
a19zdGF0ZSk7CgotCi0vKgotICogZGJjbWRzIC0gZGVidWcgY29tbWFuZHMg
YW5kIG91dHB1dCByb3V0aW5lcwotICovCi0KLXZvaWQKLWFjcGlfZGJfZGlz
cGxheV90YWJsZV9pbmZvICgKLSAgICAgICBjaGFyICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICp0YWJsZV9hcmcpOwotCi12b2lkCi1hY3BpX2RiX3Vu
bG9hZF9hY3BpX3RhYmxlICgKLSAgICAgICBjaGFyICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICp0YWJsZV9hcmcsCi0gICAgICAgY2hhciAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAqaW5zdGFuY2VfYXJnKTsKLQotdm9pZAot
YWNwaV9kYl9zZXRfbWV0aG9kX2JyZWFrcG9pbnQgKAotICAgICAgIGNoYXIg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgKmxvY2F0aW9uLAotICAgICAg
IHN0cnVjdCBhY3BpX3dhbGtfc3RhdGUgICAgICAgICAgKndhbGtfc3RhdGUs
Ci0gICAgICAgdW5pb24gYWNwaV9wYXJzZV9vYmplY3QgICAgICAgICAqb3Ap
OwotCi12b2lkCi1hY3BpX2RiX3NldF9tZXRob2RfY2FsbF9icmVha3BvaW50
ICgKLSAgICAgICB1bmlvbiBhY3BpX3BhcnNlX29iamVjdCAgICAgICAgICpv
cCk7Ci0KLXZvaWQKLWFjcGlfZGJfZGlzYXNzZW1ibGVfYW1sICgKLSAgICAg
ICBjaGFyICAgICAgICAgICAgICAgICAgICAgICAgICAgICpzdGF0ZW1lbnRz
LAotICAgICAgIHVuaW9uIGFjcGlfcGFyc2Vfb2JqZWN0ICAgICAgICAgKm9w
KTsKLQotdm9pZAotYWNwaV9kYl9kdW1wX25hbWVzcGFjZSAoCi0gICAgICAg
Y2hhciAgICAgICAgICAgICAgICAgICAgICAgICAgICAqc3RhcnRfYXJnLAot
ICAgICAgIGNoYXIgICAgICAgICAgICAgICAgICAgICAgICAgICAgKmRlcHRo
X2FyZyk7Ci0KLXZvaWQKLWFjcGlfZGJfZHVtcF9uYW1lc3BhY2VfYnlfb3du
ZXIgKAotICAgICAgIGNoYXIgICAgICAgICAgICAgICAgICAgICAgICAgICAg
Km93bmVyX2FyZywKLSAgICAgICBjaGFyICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICpkZXB0aF9hcmcpOwotCi12b2lkCi1hY3BpX2RiX3NlbmRfbm90
aWZ5ICgKLSAgICAgICBjaGFyICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICpuYW1lLAotICAgICAgIHUzMiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgdmFsdWUpOwotCi12b2lkCi1hY3BpX2RiX3NldF9tZXRob2RfZGF0YSAo
Ci0gICAgICAgY2hhciAgICAgICAgICAgICAgICAgICAgICAgICAgICAqdHlw
ZV9hcmcsCi0gICAgICAgY2hhciAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAqaW5kZXhfYXJnLAotICAgICAgIGNoYXIgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgKnZhbHVlX2FyZyk7Ci0KLWFjcGlfc3RhdHVzCi1hY3BpX2Ri
X2Rpc3BsYXlfb2JqZWN0cyAoCi0gICAgICAgY2hhciAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAqb2JqX3R5cGVfYXJnLAotICAgICAgIGNoYXIgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgKmRpc3BsYXlfY291bnRfYXJnKTsK
LQotYWNwaV9zdGF0dXMKLWFjcGlfZGJfZmluZF9uYW1lX2luX25hbWVzcGFj
ZSAoCi0gICAgICAgY2hhciAgICAgICAgICAgICAgICAgICAgICAgICAgICAq
bmFtZV9hcmcpOwotCi12b2lkCi1hY3BpX2RiX3NldF9zY29wZSAoCi0gICAg
ICAgY2hhciAgICAgICAgICAgICAgICAgICAgICAgICAgICAqbmFtZSk7Ci0K
LXZvaWQKLWFjcGlfZGJfZmluZF9yZWZlcmVuY2VzICgKLSAgICAgICBjaGFy
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICpvYmplY3RfYXJnKTsKLQot
dm9pZAotYWNwaV9kYl9kaXNwbGF5X2xvY2tzICh2b2lkKTsKLQotCi12b2lk
Ci1hY3BpX2RiX2Rpc3BsYXlfcmVzb3VyY2VzICgKLSAgICAgICBjaGFyICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICpvYmplY3RfYXJnKTsKLQotdm9p
ZAotYWNwaV9kYl9kaXNwbGF5X2dwZXMgKHZvaWQpOwotCi12b2lkCi1hY3Bp
X2RiX2NoZWNrX2ludGVncml0eSAoCi0gICAgICAgdm9pZCk7Ci0KLWFjcGlf
c3RhdHVzCi1hY3BpX2RiX2ludGVncml0eV93YWxrICgKLSAgICAgICBhY3Bp
X2hhbmRsZSAgICAgICAgICAgICAgICAgICAgIG9ial9oYW5kbGUsCi0gICAg
ICAgdTMyICAgICAgICAgICAgICAgICAgICAgICAgICAgICBuZXN0aW5nX2xl
dmVsLAotICAgICAgIHZvaWQgICAgICAgICAgICAgICAgICAgICAgICAgICAg
KmNvbnRleHQsCi0gICAgICAgdm9pZCAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAqKnJldHVybl92YWx1ZSk7Ci0KLWFjcGlfc3RhdHVzCi1hY3BpX2Ri
X3dhbGtfYW5kX21hdGNoX25hbWUgKAotICAgICAgIGFjcGlfaGFuZGxlICAg
ICAgICAgICAgICAgICAgICAgb2JqX2hhbmRsZSwKLSAgICAgICB1MzIgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIG5lc3RpbmdfbGV2ZWwsCi0gICAg
ICAgdm9pZCAgICAgICAgICAgICAgICAgICAgICAgICAgICAqY29udGV4dCwK
LSAgICAgICB2b2lkICAgICAgICAgICAgICAgICAgICAgICAgICAgICoqcmV0
dXJuX3ZhbHVlKTsKLQotYWNwaV9zdGF0dXMKLWFjcGlfZGJfd2Fsa19mb3Jf
cmVmZXJlbmNlcyAoCi0gICAgICAgYWNwaV9oYW5kbGUgICAgICAgICAgICAg
ICAgICAgICBvYmpfaGFuZGxlLAotICAgICAgIHUzMiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgbmVzdGluZ19sZXZlbCwKLSAgICAgICB2b2lkICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICpjb250ZXh0LAotICAgICAgIHZv
aWQgICAgICAgICAgICAgICAgICAgICAgICAgICAgKipyZXR1cm5fdmFsdWUp
OwotCi1hY3BpX3N0YXR1cwotYWNwaV9kYl93YWxrX2Zvcl9zcGVjaWZpY19v
YmplY3RzICgKLSAgICAgICBhY3BpX2hhbmRsZSAgICAgICAgICAgICAgICAg
ICAgIG9ial9oYW5kbGUsCi0gICAgICAgdTMyICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBuZXN0aW5nX2xldmVsLAotICAgICAgIHZvaWQgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgKmNvbnRleHQsCi0gICAgICAgdm9pZCAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAqKnJldHVybl92YWx1ZSk7Ci0K
LXZvaWQKLWFjcGlfZGJfZ2VuZXJhdGVfZ3BlICgKLSAgICAgICBjaGFyICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICpncGVfYXJnLAotICAgICAgIGNo
YXIgICAgICAgICAgICAgICAgICAgICAgICAgICAgKmJsb2NrX2FyZyk7Ci0K
IC8qCiAgKiBkYmRpc3BseSAtIGRlYnVnIGRpc3BsYXkgY29tbWFuZHMKICAq
LwoKIHZvaWQKLWFjcGlfZGJfZGlzcGxheV9tZXRob2RfaW5mbyAoCi0gICAg
ICAgdW5pb24gYWNwaV9wYXJzZV9vYmplY3QgICAgICAgICAqb3ApOwotCi12
b2lkCi1hY3BpX2RiX2RlY29kZV9hbmRfZGlzcGxheV9vYmplY3QgKAotICAg
ICAgIGNoYXIgICAgICAgICAgICAgICAgICAgICAgICAgICAgKnRhcmdldCwK
LSAgICAgICBjaGFyICAgICAgICAgICAgICAgICAgICAgICAgICAgICpvdXRw
dXRfdHlwZSk7Ci0KLXZvaWQKIGFjcGlfZGJfZGlzcGxheV9yZXN1bHRfb2Jq
ZWN0ICgKICAgICAgICB1bmlvbiBhY3BpX29wZXJhbmRfb2JqZWN0ICAgICAg
ICpvYmpfZGVzYywKICAgICAgICBzdHJ1Y3QgYWNwaV93YWxrX3N0YXRlICAg
ICAgICAgICp3YWxrX3N0YXRlKTsKCi1hY3BpX3N0YXR1cwotYWNwaV9kYl9k
aXNwbGF5X2FsbF9tZXRob2RzICgKLSAgICAgICBjaGFyICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICpkaXNwbGF5X2NvdW50X2FyZyk7Ci0KLXZvaWQK
LWFjcGlfZGJfZGlzcGxheV9hcmd1bWVudHMgKAotICAgICAgIHZvaWQpOwot
Ci12b2lkCi1hY3BpX2RiX2Rpc3BsYXlfbG9jYWxzICgKLSAgICAgICB2b2lk
KTsKLQotdm9pZAotYWNwaV9kYl9kaXNwbGF5X3Jlc3VsdHMgKAotICAgICAg
IHZvaWQpOwotCi12b2lkCi1hY3BpX2RiX2Rpc3BsYXlfY2FsbGluZ190cmVl
ICgKLSAgICAgICB2b2lkKTsKLQotdm9pZAotYWNwaV9kYl9kaXNwbGF5X29i
amVjdF90eXBlICgKLSAgICAgICBjaGFyICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICpvYmplY3RfYXJnKTsKLQogdm9pZAogYWNwaV9kYl9kaXNwbGF5
X2FyZ3VtZW50X29iamVjdCAoCiAgICAgICAgdW5pb24gYWNwaV9vcGVyYW5k
X29iamVjdCAgICAgICAqb2JqX2Rlc2MsCiAgICAgICAgc3RydWN0IGFjcGlf
d2Fsa19zdGF0ZSAgICAgICAgICAqd2Fsa19zdGF0ZSk7Cgotdm9pZAotYWNw
aV9kYl9kdW1wX3BhcnNlcl9kZXNjcmlwdG9yICgKLSAgICAgICB1bmlvbiBh
Y3BpX3BhcnNlX29iamVjdCAgICAgICAgICpvcCk7Ci0KLXZvaWQgKgotYWNw
aV9kYl9nZXRfcG9pbnRlciAoCi0gICAgICAgdm9pZCAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAqdGFyZ2V0KTsKLQotCi0vKgotICogZGJleGVjIC0g
ZGVidWdnZXIgY29udHJvbCBtZXRob2QgZXhlY3V0aW9uCi0gKi8KLQotdm9p
ZAotYWNwaV9kYl9leGVjdXRlICgKLSAgICAgICBjaGFyICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICpuYW1lLAotICAgICAgIGNoYXIgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgKiphcmdzLAotICAgICAgIHUzMiAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgZmxhZ3MpOwotCi12b2lkCi1hY3BpX2Ri
X2NyZWF0ZV9leGVjdXRpb25fdGhyZWFkcyAoCi0gICAgICAgY2hhciAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAqbnVtX3RocmVhZHNfYXJnLAotICAg
ICAgIGNoYXIgICAgICAgICAgICAgICAgICAgICAgICAgICAgKm51bV9sb29w
c19hcmcsCi0gICAgICAgY2hhciAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAqbWV0aG9kX25hbWVfYXJnKTsKLQotYWNwaV9zdGF0dXMKLWFjcGlfZGJf
ZXhlY3V0ZV9tZXRob2QgKAotICAgICAgIHN0cnVjdCBhY3BpX2RiX21ldGhv
ZF9pbmZvICAgICAgKmluZm8sCi0gICAgICAgc3RydWN0IGFjcGlfYnVmZmVy
ICAgICAgICAgICAgICAqcmV0dXJuX29iaik7Ci0KLXZvaWQKLWFjcGlfZGJf
ZXhlY3V0ZV9zZXR1cCAoCi0gICAgICAgc3RydWN0IGFjcGlfZGJfbWV0aG9k
X2luZm8gICAgICAqaW5mbyk7Ci0KLXUzMgotYWNwaV9kYl9nZXRfb3V0c3Rh
bmRpbmdfYWxsb2NhdGlvbnMgKAotICAgICAgIHZvaWQpOwotCi12b2lkIEFD
UElfU1lTVEVNX1hGQUNFCi1hY3BpX2RiX21ldGhvZF90aHJlYWQgKAotICAg
ICAgIHZvaWQgICAgICAgICAgICAgICAgICAgICAgICAgICAgKmNvbnRleHQp
OwotCi1hY3BpX3N0YXR1cwotYWNwaV9kYl9leGVjdXRpb25fd2FsayAoCi0g
ICAgICAgYWNwaV9oYW5kbGUgICAgICAgICAgICAgICAgICAgICBvYmpfaGFu
ZGxlLAotICAgICAgIHUzMiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
bmVzdGluZ19sZXZlbCwKLSAgICAgICB2b2lkICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICpjb250ZXh0LAotICAgICAgIHZvaWQgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgKipyZXR1cm5fdmFsdWUpOwotCi0KLS8qCi0gKiBk
YmZpbGVpbyAtIERlYnVnZ2VyIGZpbGUgSS9PIGNvbW1hbmRzCi0gKi8KLQot
YWNwaV9vYmplY3RfdHlwZQotYWNwaV9kYl9tYXRjaF9hcmd1bWVudCAoCi0g
ICAgICAgY2hhciAgICAgICAgICAgICAgICAgICAgICAgICAgICAqdXNlcl9h
cmd1bWVudCwKLSAgICAgICBzdHJ1Y3QgYXJndW1lbnRfaW5mbyAgICAgICAg
ICAgICphcmd1bWVudHMpOwotCi1hY3BpX3N0YXR1cwotYWVfbG9jYWxfbG9h
ZF90YWJsZSAoCi0gICAgICAgc3RydWN0IGFjcGlfdGFibGVfaGVhZGVyICAg
ICAgICAqdGFibGVfcHRyKTsKLQotdm9pZAotYWNwaV9kYl9jbG9zZV9kZWJ1
Z19maWxlICgKLSAgICAgICB2b2lkKTsKLQotdm9pZAotYWNwaV9kYl9vcGVu
X2RlYnVnX2ZpbGUgKAotICAgICAgIGNoYXIgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgKm5hbWUpOwotCi1hY3BpX3N0YXR1cwotYWNwaV9kYl9sb2Fk
X2FjcGlfdGFibGUgKAotICAgICAgIGNoYXIgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgKmZpbGVuYW1lKTsKLQotYWNwaV9zdGF0dXMKLWFjcGlfZGJf
Z2V0X3RhYmxlX2Zyb21fZmlsZSAoCi0gICAgICAgY2hhciAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAqZmlsZW5hbWUsCi0gICAgICAgc3RydWN0IGFj
cGlfdGFibGVfaGVhZGVyICAgICAgICAqKnRhYmxlKTsKLQotYWNwaV9zdGF0
dXMKLWFjcGlfZGJfcmVhZF90YWJsZV9mcm9tX2ZpbGUgKAotICAgICAgIGNo
YXIgICAgICAgICAgICAgICAgICAgICAgICAgICAgKmZpbGVuYW1lLAotICAg
ICAgIHN0cnVjdCBhY3BpX3RhYmxlX2hlYWRlciAgICAgICAgKip0YWJsZSk7
Ci0KLS8qCi0gKiBkYmhpc3RyeSAtIGRlYnVnZ2VyIEhJU1RPUlkgY29tbWFu
ZAotICovCi0KLXZvaWQKLWFjcGlfZGJfYWRkX3RvX2hpc3RvcnkgKAotICAg
ICAgIGNoYXIgICAgICAgICAgICAgICAgICAgICAgICAgICAgKmNvbW1hbmRf
bGluZSk7Ci0KLXZvaWQKLWFjcGlfZGJfZGlzcGxheV9oaXN0b3J5ICh2b2lk
KTsKLQotY2hhciAqCi1hY3BpX2RiX2dldF9mcm9tX2hpc3RvcnkgKAotICAg
ICAgIGNoYXIgICAgICAgICAgICAgICAgICAgICAgICAgICAgKmNvbW1hbmRf
bnVtX2FyZyk7Ci0KLQogLyoKICAqIGRiaW5wdXQgLSB1c2VyIGZyb250LWVu
ZCB0byB0aGUgQU1MIGRlYnVnZ2VyCiAgKi8KCiBhY3BpX3N0YXR1cwotYWNw
aV9kYl9jb21tYW5kX2Rpc3BhdGNoICgKLSAgICAgICBjaGFyICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICppbnB1dF9idWZmZXIsCi0gICAgICAgc3Ry
dWN0IGFjcGlfd2Fsa19zdGF0ZSAgICAgICAgICAqd2Fsa19zdGF0ZSwKLSAg
ICAgICB1bmlvbiBhY3BpX3BhcnNlX29iamVjdCAgICAgICAgICpvcCk7Ci0K
LXZvaWQgQUNQSV9TWVNURU1fWEZBQ0UKLWFjcGlfZGJfZXhlY3V0ZV90aHJl
YWQgKAotICAgICAgIHZvaWQgICAgICAgICAgICAgICAgICAgICAgICAgICAg
KmNvbnRleHQpOwotCi1hY3BpX3N0YXR1cwogYWNwaV9kYl91c2VyX2NvbW1h
bmRzICgKICAgICAgICBjaGFyICAgICAgICAgICAgICAgICAgICAgICAgICAg
IHByb21wdCwKICAgICAgICB1bmlvbiBhY3BpX3BhcnNlX29iamVjdCAgICAg
ICAgICpvcCk7Cgotdm9pZAotYWNwaV9kYl9kaXNwbGF5X2hlbHAgKAotICAg
ICAgIGNoYXIgICAgICAgICAgICAgICAgICAgICAgICAgICAgKmhlbHBfdHlw
ZSk7Ci0KLWNoYXIgKgotYWNwaV9kYl9nZXRfbmV4dF90b2tlbiAoCi0gICAg
ICAgY2hhciAgICAgICAgICAgICAgICAgICAgICAgICAgICAqc3RyaW5nLAot
ICAgICAgIGNoYXIgICAgICAgICAgICAgICAgICAgICAgICAgICAgKipuZXh0
KTsKLQotdTMyCi1hY3BpX2RiX2dldF9saW5lICgKLSAgICAgICBjaGFyICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICppbnB1dF9idWZmZXIpOwotCi11
MzIKLWFjcGlfZGJfbWF0Y2hfY29tbWFuZCAoCi0gICAgICAgY2hhciAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAqdXNlcl9jb21tYW5kKTsKLQotdm9p
ZAotYWNwaV9kYl9zaW5nbGVfdGhyZWFkICgKLSAgICAgICB2b2lkKTsKLQot
Ci0vKgotICogZGJzdGF0cyAtIEdlbmVyYXRpb24gYW5kIGRpc3BsYXkgb2Yg
QUNQSSB0YWJsZSBzdGF0aXN0aWNzCi0gKi8KLQotdm9pZAotYWNwaV9kYl9n
ZW5lcmF0ZV9zdGF0aXN0aWNzICgKLSAgICAgICB1bmlvbiBhY3BpX3BhcnNl
X29iamVjdCAgICAgICAgICpyb290LAotICAgICAgIHU4ICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgaXNfbWV0aG9kKTsKLQotCi1hY3BpX3N0YXR1
cwotYWNwaV9kYl9kaXNwbGF5X3N0YXRpc3RpY3MgKAotICAgICAgIGNoYXIg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgKnR5cGVfYXJnKTsKLQotYWNw
aV9zdGF0dXMKLWFjcGlfZGJfY2xhc3NpZnlfb25lX29iamVjdCAoCi0gICAg
ICAgYWNwaV9oYW5kbGUgICAgICAgICAgICAgICAgICAgICBvYmpfaGFuZGxl
LAotICAgICAgIHUzMiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgbmVz
dGluZ19sZXZlbCwKLSAgICAgICB2b2lkICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICpjb250ZXh0LAotICAgICAgIHZvaWQgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgKipyZXR1cm5fdmFsdWUpOwotCi12b2lkCi1hY3BpX2Ri
X2NvdW50X25hbWVzcGFjZV9vYmplY3RzICgKLSAgICAgICB2b2lkKTsKLQot
dm9pZAotYWNwaV9kYl9lbnVtZXJhdGVfb2JqZWN0ICgKLSAgICAgICB1bmlv
biBhY3BpX29wZXJhbmRfb2JqZWN0ICAgICAgICpvYmpfZGVzYyk7Ci0KLQot
LyoKLSAqIGRidXRpbHMgLSBBTUwgZGVidWdnZXIgdXRpbGl0aWVzCi0gKi8K
LQotdm9pZAotYWNwaV9kYl9zZXRfb3V0cHV0X2Rlc3RpbmF0aW9uICgKLSAg
ICAgICB1MzIgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHdoZXJlKTsK
LQotdm9pZAotYWNwaV9kYl9kdW1wX2J1ZmZlciAoCi0gICAgICAgdTMyICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBhZGRyZXNzKTsKLQotdm9pZAot
YWNwaV9kYl9kdW1wX29iamVjdCAoCi0gICAgICAgdW5pb24gYWNwaV9vYmpl
Y3QgICAgICAgICAgICAgICAqb2JqX2Rlc2MsCi0gICAgICAgdTMyICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBsZXZlbCk7Ci0KLXZvaWQKLWFjcGlf
ZGJfcHJlcF9uYW1lc3RyaW5nICgKLSAgICAgICBjaGFyICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICpuYW1lKTsKLQotCi1hY3BpX3N0YXR1cwotYWNw
aV9kYl9zZWNvbmRfcGFzc19wYXJzZSAoCi0gICAgICAgdW5pb24gYWNwaV9w
YXJzZV9vYmplY3QgICAgICAgICAqcm9vdCk7Ci0KLXN0cnVjdCBhY3BpX25h
bWVzcGFjZV9ub2RlICoKLWFjcGlfZGJfbG9jYWxfbnNfbG9va3VwICgKLSAg
ICAgICBjaGFyICAgICAgICAgICAgICAgICAgICAgICAgICAgICpuYW1lKTsK
LQotCiAjZW5kaWYgIC8qIF9fQUNERUJVR19IX18gKi8K

--0-2119703764-1090282832=:62264--
